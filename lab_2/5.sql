-- 05 --
select cr.num, cr.brand
from Car cr
where exists (select cr.num
			  from Car cr join Orders ord on cr.num = ord.car_num
			  		  join Passenger pas on ord.passenger_id = pas.id
			  where pas.age > 95);
