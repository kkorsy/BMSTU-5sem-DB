-- 07 --
select avg(FullPrice) as "Predicted avg",
	   sum(FullPrice) as "Sum withot extra"
from (select ord.id, sum(ord.price * dr.rating / 100) as FullPrice
	  from Orders ord join Driver dr on ord.driver_id = dr.id
	  group by ord.id
	  ) as FullOrders;
