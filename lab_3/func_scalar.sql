-- скалярная функция
create or replace function max_passenger_age()
returns int as 
$$
begin
	return (select max(age) as max_age
		    from Passenger);
end;
$$
language plpgsql;

select *
from Passenger
where name like 'A%' and age = max_passenger_age();