-- 22 --
with otv (rating) as (
	select rating
	from Passenger
	where age > 30
)
select avg(rating)
from otv;
