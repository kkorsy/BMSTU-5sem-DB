-- триггер INSTEAD OF

create or replace function block_insert()
returns trigger as
$$
begin
	raise notice 'Previous insertion was blocked';
	return new;
end;
$$ language plpgsql;

create or replace view car_view as
select * 
from Car;

create or replace trigger block_insert
instead of insert on car_view
for each row
execute function block_insert();

insert into car_view values
('C010WQ107', 'Ford', 12000, 2012, 'Diesel');
