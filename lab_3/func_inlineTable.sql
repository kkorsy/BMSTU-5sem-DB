-- подставляемая табличная функция
create or replace function driver_order_before_date(driver_name varchar(255), date_before date)
returns table (passenger_id int,
			   passenger_name varchar(255),
			   dr_name varchar(255),
			   ord_date date) as
$$
begin
	return query select pas.id, pas.name, dr.name, ord.order_date
				 from Passenger pas join Orders ord on pas.id = ord.passenger_id
				 					join Driver dr on ord.driver_id = dr.id
				 where dr.name = driver_name and ord.order_date <= date_before;
end;
$$
language plpgsql;

select *
from driver_order_before_date('Mary', '2010-02-07')