-- Извлечь JSON фрагмент из JSON документа
drop table if exists driver_json;
create temp table driver_json 
(
    js_data jsonb
);

insert into driver_json(js_data) values
('{"id": 1, "name": "Daniel", "age": 20, "rating": 4.8, "order": {"order_id": 3, "order_date": "2023-11-15"}}'),
('{"id": 2, "name": "Kate", "age": 18, "rating": 2.5, "order": {"order_id": 5, "order_date": "2020-10-05"}}'),
('{"id": 3, "name": "Liza", "age": 35, "rating": 3.0, "order": {"order_id": 1, "order_date": "2015-04-25"}}'),
('{"id": 4, "name": "Mike", "age": 26, "rating": 5.0, "order": {"order_id": 2, "order_date": "2021-06-01"}}'),
('{"id": 5, "name": "George", "age": 51, "rating": 1.7, "order": {"order_id": 4, "order_date": "2018-09-17"}}');

select js_data->>'name' as name, js_data->'rating' as rating
from driver_json;

-- Извлечь значения конкретных узлов или атрибутов JSON документа
select *
from driver_json
where js_data->>'name' like '%e';

-- Выполнить проверку существования узла или атрибута
create or replace function is_exists(js_data jsonb, val varchar) 
returns bool as
$$
begin
	return (js_data->>val) is not null;
end;
$$
language plpgsql;

select distinct is_exists(driver_json.js_data, 'surname')
from driver_json;

-- Изменить JSON документ
update driver_json
set js_data = js_data || '{"age": 22}'::jsonb
where (js_data->>'id')::int = 2;

select (js_data->>'age')::int as age
from driver_json dj
where (js_data->>'id')::int = 2;

-- Разделить JSON документ на несколько строк по узлам
drop table if exists driver_json;
create temp table driver_json 
(
    js_data jsonb
);

insert into driver_json(js_data) values
('[
 	{"id": 1, "name": "Daniel", "age": 20, "rating": 4.8, "order": {"order_id": 3, "order_date": "2023-11-15"}},
	{"id": 2, "name": "Kate", "age": 18, "rating": 2.5, "order": {"order_id": 5, "order_date": "2020-10-05"}},
	{"id": 3, "name": "Liza", "age": 35, "rating": 3.0, "order": {"order_id": 1, "order_date": "2015-04-25"}},
	{"id": 4, "name": "Mike", "age": 26, "rating": 5.0, "order": {"order_id": 2, "order_date": "2021-06-01"}},
	{"id": 5, "name": "George", "age": 51, "rating": 1.7, "order": {"order_id": 4, "order_date": "2018-09-17"}}
 ]');
 
 select jsonb_array_elements(js_data::jsonb)
 from driver_json;
