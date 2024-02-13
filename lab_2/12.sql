-- 12 --
select Passenger.name, Passenger.surname, (
	select sum(Orders.price) 
	from Orders
	where Orders.passenger_id = Passenger.id
) as total_spent
from Passenger;
