import psycopg2
from config import *


# Выполнить скалярный запрос
def task_1(cn):
    cursor = cn.cursor()
    cursor.execute("select max(age) as max_age from Passenger")

    print(cursor.fetchone()[0])


# Выполнить запрос с несколькими соединениями (JOIN)
def task_2(cn):
    cursor = cn.cursor()
    cursor.execute("select cr.num, cr.brand\
                    from Car cr\
                    where exists (select cr.num\
                    from Car cr join Orders ord on cr.num = ord.car_num\
                        join Passenger pas on ord.passenger_id = pas.id\
                    where pas.age = 99);")
    res = cursor.fetchall()
    for r in res:
        print(*r)


# Выполнить запрос с ОТВ(CTE) и оконными функциями
def task_3(cn):
    cursor = cn.cursor()
    cursor.execute("with avg_price as \
                    ( \
                    select id, price, avg(price) over (partition by passenger_id) \
                    from Orders \
                    ) \
                    select * from avg_price")
    res = cursor.fetchall()
    for r in res:
        print(*r)


# Выполнить запрос к метаданным
def task_4(cn):
    schema_name = 'public'
    cursor = cn.cursor()
    cursor.execute("select routines.routine_name \
                        from information_schema.routines left join information_schema.parameters on routines.specific_name = parameters.specific_name \
                        where routines.specific_schema = %s \
                        group by routines.routine_name", (schema_name,))
    res = cursor.fetchall()
    for r in res:
        print(*r)


# Вызвать скалярную функцию (написанную в третьей лабораторной работе)
def task_5(cn):
    cursor = cn.cursor()
    cursor.execute("select max_passenger_age()")
    print(cursor.fetchone()[0])


# Вызвать многооператорную или табличную функцию (написанную в третьей лабораторной работе)
def task_6(cn):
    cursor = cn.cursor()
    cursor.execute("select *\
                    from get_passenger_info(112)")
    res = cursor.fetchall()
    for r in res:
        print(*r)


# Вызвать хранимую процедуру (написанную в третьей лабораторной работе)
def task_7(cn):
    cursor = cn.cursor()
    cursor.execute("call add_order_price('1972-06-19', 150);\
                    select id, order_date, price\
                    from Orders\
                    where order_date = '1972-06-19';")
    res = cursor.fetchall()
    for r in res:
        print(*r)


# Вызвать системную функцию или процедуру
def task_8(cn):
    cursor = cn.cursor()
    cursor.execute("select current_database(), current_schema(), current_user;")
    print(*cursor.fetchall())


# Создать таблицу в базе данных, соответствующую тематике БД
def task_9(cn):
    cursor = cn.cursor()
    cursor.execute("""
                        drop table if exists address;
                        create table address
                        (
                            id serial primary key,
                            id_passenger int,
                            city varchar,
                            street varchar,
                            house int,
                            foreign key(id_passenger) references passenger(id)
                        )
                       """)

    cn.commit()
    print(f'Таблица успешно создана.')


# Выполнить вставку данных в созданную таблицу с использованием инструкции INSERT или COPY
def task_10(cn):
    cursor = cn.cursor()
    cursor.execute("select exists(select * from information_schema.tables where table_name=%s)", ('address',))
    if cursor.fetchone()[0]:
        cursor.execute("""
                            insert into address(id_passenger, city, street, house) values
                            (120, 'Moscow', 'Bauman', 10),
                            (238, 'Kazan', 'Korolev', 12),
                            (16, 'St Petersburg', 'Lenin', 3);
    
                            select *
                            from address;
                           """)

        cn.commit()
        res = cursor.fetchall()
        for r in res:
            print(*r)
    else:
        print("Таблица не существует")


def menu():
    print("\n1.  Выполнить скалярный запрос. \n" +
          "2.  Выполнить запрос с несколькими соединениями (join).\n" +
          "3.  Выполнить запрос с ОТВ(СТЕ) и оконными функциями.\n" +
          "4.  Выполнить запрос к метаданным.\n" +
          "5.  Вызвать скалярную функцию из ЛР3.\n" +
          "6.  Вызвать многоператорную или табличную функцию из ЛР3.\n" +
          "7.  Вызвать хранимую процедуру.\n" +
          "8.  Вызвать системную функцию или процедуру.\n" +
          "9.  Создать таблицу в базе данных, соответствующей тематике БД.\n" +
          "10. Выполнить вставку данных в созданную таблицу с использованием insert или copy.\n" +
          "0.  Выход.\n")


if __name__ == "__main__":
    try:
        connection = psycopg2.connect(
            database=DB_NAME,
            user=DB_USER,
            password=DB_PWD,
            host=DB_HOST
        )
    except Exception:
        print("Ошибка при подключении к БД")
        exit(-1)
    print("База данных успешно открыта.\n")

    tasks = [0, task_1, task_2, task_3, task_4, task_5, task_6, task_7, task_8, task_9, task_10]
    menu()
    cmd = int(input("Выберите пункт меню: "))
    while cmd != 0:
        if cmd < 0 or cmd > 10:
            print("Неверная команда\n")
        else:
            tasks[cmd](connection)
        menu()
        cmd = int(input("Выберите пункт меню: "))

    connection.close()
    print("База данных успешно закрыта.")
