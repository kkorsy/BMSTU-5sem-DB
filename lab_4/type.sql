-- определяемый пользователем тип данных

-- create type driver_ns as
-- (
-- 	name varchar,
-- 	surname varchar
-- );

create or replace function drivers_ns_by_age(age int)
returns setof driver_ns as
$$
	query = '''
	select name, surname
	from Driver dr
	where dr.age = %s
	''' % (age)
	res = plpy.execute(query)
	
	return res
$$
language plpython3u;

select *
from drivers_ns_by_age(100);
