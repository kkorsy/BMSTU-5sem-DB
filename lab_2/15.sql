-- 15 --
select rating, count(rating)
from Passenger
group by rating
having rating > 3;
