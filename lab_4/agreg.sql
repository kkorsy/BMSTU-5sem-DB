-- пользовательская агрегатная функция

create or replace function cnt_passengers_by_rating(rating float)
returns int as
$$
	query = '''
	select *
	from Passenger as p
	where p.rating = '%s'
	''' % (rating)
	res = plpy.execute(query)

	cnt = 0
	if res is not None:
		for _ in res:
			cnt += 1
	return cnt
$$
language plpython3u;

select rating, cnt_passengers_by_rating(rating)
from Passenger
group by rating
