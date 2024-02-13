-- определяемая пользователем табличная функция
create or replace function cars_by_year(year int)
returns table(num varchar, brand varchar, mileage int, release_year int) as
$$
    query = '''
        select *
		from Car as c
		where c.release_year = '%s'
		''' % (year)
    res = plpy.execute(query)
	
    res_table = list()
    if res is not None:
        for car in res:
            res_table.append(car)

    return res_table

$$ language plpython3u;


select *
from cars_by_year(2000);
