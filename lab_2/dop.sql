-- Создать таблицы:
-- • Table1{id: integer, var1: string, valid_from_dttm: date, valid_to_dttm: date}
-- • Table2{id: integer, var2: string, valid_from_dttm: date, valid_to_dttm: date}
-- Версионность в таблицах непрерывная, разрывов нет (если valid_to_dttm = '2018-09-05', 
-- то для следующей строки соответствующего ID valid_from_dttm = '2018-09-06', т.е. на день больше). 
-- Для каждого ID дата начала версионности и дата конца версионности в Table1 и Table2 совпадают.
-- Выполнить версионное соединение двух талиц по полю id.


drop table if exists table_1, table_2;
create table if not exists table_1
(
	id int,
	var1 varchar(50),
	valid_from_dttm date,
	valid_to_dttm date
);

CREATE TABLE IF NOT EXISTS table_2
(
	id int,
	var2 varchar(50),
	valid_from_dttm date,
	valid_to_dttm date
);

insert into table_1(id, var1, valid_from_dttm, valid_to_dttm) values
(1, 'A', '2018-09-01', '2018-09-15'),
(1, 'B', '2018-09-16', '2018-09-22'),
(1, 'C', '2018-09-23', '5999-12-31');

insert into table_2(id, var2, valid_from_dttm, valid_to_dttm) values
(1, 'A', '2018-09-01', '2018-09-18'),
(1, 'B', '2018-09-19', '2018-09-25'),
(1, 'C', '2018-09-26', '5999-12-31');


with dates as
(
	select t1.id, t1.var1, t2.var2, greatest(t1.valid_from_dttm, t2.valid_from_dttm) as valid_from_dttm, least(t1.valid_to_dttm, t2.valid_to_dttm) as valid_to_dttm
	from table_1 as t1 join table_2 as t2 on t1.id = t2.id
)

select *
from dates
where valid_from_dttm <= valid_to_dttm
order by id, valid_from_dttm;