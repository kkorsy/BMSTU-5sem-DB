-- многооператорная табличная функция
create or replace function get_passenger_info(id_pas int)
returns table(id int,
		ord_date date,
		ord_price int,
		driver_id int) as
$$
begin
	drop table if exists passenger_info;
	
	create temp table passenger_info
	(
		id int,
		ord_date date,
		ord_price int,
		driver_id int
		
	);
	
	insert into passenger_info(id, ord_date, ord_price, driver_id)
		select pod.passenger_id, pod.order_date, pod.price, pod.driver_id
		from ((Orders ord join Passenger pas on ord.passenger_id = pas.id) join Driver dr on dr.id = ord.driver_id) as pod
		where POD.passenger_id = id_pas;
		
	return query
	
	select *
	from passenger_info;
end;
$$ language plpgsql;

select *
from get_passenger_info(113);
