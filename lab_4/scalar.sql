-- определяемая пользователем скалярная функция CLR

create or replace function max_passenger_age()
returns int as 
$$
	res = plpy.execute(f"select max(age) as max_age\
		    			from Passenger");
	if res:
		return res[0]['max_age']
$$
language plpython3u;

select *
from Passenger
where name like 'A%' and age = max_passenger_age();

