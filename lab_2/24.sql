-- 24 --
select age, 
	avg(rating) over(partition by age) as AvgRating,
	min(rating) over(partition by age) as MinRating,
	max(rating) over(partition by age) as MaxRating
from Passenger;
