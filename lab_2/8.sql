-- 08 --
select dr.name, dr.age,
	   (select avg(age)
	    from Driver
	    where rating > 2.5) as AvgAge,
		(select max(age)
		 from Driver
		 where rating < 1.5) as MaxAge
from Driver dr
where tariff = 'Comfort+';
