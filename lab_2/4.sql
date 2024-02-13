-- 04 --
select name, tariff
from Driver dr
where dr.id in (select driver_id				
				from Orders
			    where price > 3500);
