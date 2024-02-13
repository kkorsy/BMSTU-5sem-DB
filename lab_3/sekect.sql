-- триггер на insert

create or replace function instead_insert()
returns trigger as
$$
declare found_id int;
begin
	-- подобрать водителя с наименьшим числом заказов
	select driver_id
	from Orders ord
	group by driver_id
	having count(ord.id) = (select min(cnt) as m
						    from (select driver_id, count(ord.id) as cnt
								  from Orders ord 
						    	  group by driver_id) t
						   )
	into found_id;
	
	raise notice '%', found_id;
	
	insert into Orders values
	(new.id, new.passenger_id, found_id, new.car_num, new.order_date, new.price);
	
	return new;
end;
$$ language plpgsql;

create or replace view ord_view as
select * 
from Orders;

create or replace trigger trig_insert
instead of insert on ord_view
for each row
execute function instead_insert();

insert into ord_view values
(121212122, 15, 15, 'A010WQ107', '2023-11-10', 1234);

select *
from Orders ord
where ord.id = 121212122;