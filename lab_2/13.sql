-- 13 --
select Driver.id, Driver.name, Driver.surname
from Driver
where Driver.id = (select Orders.driver_id
				   from Orders
				   group by Orders.driver_id
				   having sum(Orders.price) = (select max(SP)
											   from (select sum(Orders.price) as SP
													 from Orders
													 group by Orders.driver_id
													) as DP
											  )
				  );
