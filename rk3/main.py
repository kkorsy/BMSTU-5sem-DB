from peewee import *
from req import *

con = PostgresqlDatabase(
    database='db_labs',
    user='postgres',
    password='5454038',
    host='127.0.0.1',
    port="5432"
)


class BaseModel(Model):
    class Meta:
        database = con


class Employee(BaseModel):
    id = IntegerField(column_name='id')
    fio = CharField(column_name='fio')
    date_of_birth = DateField(column_name='date_of_birth')
    department = CharField(column_name='department')

    class Meta:
        table_name = 'employee'


class EmployeeAttendance(BaseModel):
    id = IntegerField(column_name='id')
    employee_id = ForeignKeyField(Employee, backref='employee_id')
    data = DateField(column_name='date')
    day_of_week =  CharField(column_name='day_of_week')
    time = TimeField(column_name='time')
    type = IntegerField(column_name='type')

    class Meta:
        table_name = 'employee_attendance'


def task1():
    global con
    cur = con.cursor()

    cur.execute(req1)
    print("Request 1:\n")
    rows = cur.fetchall()
    for row in rows:
        print(*row)

    cur.execute(req2)
    print("\nRequest 2:\n")
    rows = cur.fetchall()
    for row in rows:
        print(*row)

    cur.execute(req3)
    print("\nRequest 3:\n")
    rows = cur.fetchall()
    for row in rows:
        print(*row)

    cur.close()


def task2():
    print("1")
    query = (Employee
             .select(Employee.department)
             .where(fn.EXTRACT('month', Employee.date_of_birth) == 5)
             .where(~(Employee.id.in_(
                    Employee
                        .select(Employee.id)
                        .where(fn.EXTRACT('month', Employee.date_of_birth) != 5)
                ))).distinct())
    for result in query:
        print(result.department)

    print("2")
    query = (Employee
        .select(Employee.fio)
        .join(EmployeeAttendance, on=(Employee.id == EmployeeAttendance.employee_id))
        .where(Employee.id.in_(
                EmployeeAttendance
                    .select(EmployeeAttendance.employee_id)
                    .group_by(EmployeeAttendance.employee)
                    .having(fn.COUNT(EmployeeAttendance.type) == 2)
    )))
    for result in query:
        print(result.department)

    print("3")
    query = (Employee
             .select(Employee.fio)
             .join(EmployeeAttendance, on=(Employee.id == EmployeeAttendance.employee_id))
             .where(Employee.department == 'Бухгалтерия')
             .where(EmployeeAttendance.time.in_(
                    EmployeeAttendance
                        .select(fn.MIN(EmployeeAttendance.time))
                        .where(EmployeeAttendance.type == 1)
                        .group_by(EmployeeAttendance.id)
                        .having(EmployeeAttendance.time < '9:00')
    ))
             )
    for result in query:
        print(result.department)


if __name__ == "__main__":
    task1()
    task2()
    con.close()
