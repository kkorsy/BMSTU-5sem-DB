-- Выполнить загрузку и сохранение JSON файла в таблицу

drop table if exists pas_json;
create temp table pas_json
(
    id                int PRIMARY KEY,
    name              varchar(255) not null,
    surname           varchar(255) not null,
    rating            float,
    age               int,
    phone_number      varchar(13)
);

drop table if exists json_table;
create temp table json_table
(
    data jsonb
);

copy json_table from 'D:/DB/lab_5/passenger.json';

insert into pas_json(id, name, surname, rating, age, phone_number)
select (data->>'id')::int, (data->>'name')::varchar, (data->>'surname')::varchar, (data->>'rating')::float, (data->>'age')::int, (data->>'phone_number')::varchar
from json_table;

select *
from pas_json;
