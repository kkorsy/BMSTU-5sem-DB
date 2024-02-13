-- 06 --
select name, rating
from Driver dr
where rating > ALL(select pas.rating
					  from Passenger pas
					  where pas.age = 28);
