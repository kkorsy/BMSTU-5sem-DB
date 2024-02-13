-- Создать таблицу, в которой будет атрибут JSON
-- Заполнить атрибут правдоподобными данными с помощью INSERT 

drop table if exists driver_json;
create temp table driver_json 
(
    data jsonb
);

insert into driver_json(data) values
('{"id": 1, "name": "Daniel", "age": 20, "rating": 4.8}'),
('{"id": 2, "name": "Kate", "age": 18, "rating": 2.5}'),
('{"id": 3, "name": "Liza", "age": 35, "rating": 3.0}'),
('{"id": 4, "name": "Mike", "age": 26, "rating": 5.0}'),
('{"id": 5, "name": "George", "age": 51, "rating": 1.7}');

select *
from driver_json;
