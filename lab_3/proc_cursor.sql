-- хранимая процедура с курсором

create or replace procedure info_orders(from_price int, to_price int)
as
$$
declare cur_order record;
		order_cursor cursor for
			select *
			from Orders ord
			where ord.price between from_price and to_price
			order by ord.price;
begin
	open order_cursor;
	
	loop
		fetch order_cursor into cur_order;
		exit when not found;
		raise notice 'Info: id: %, passenger_id: %, driver_id: %, order_date: %, price: %', 
			cur_order.id, cur_order.passenger_id, cur_order.driver_id, cur_order.order_date, cur_order.price;
	end loop;
	
	close order_cursor;
end;
$$ language plpgsql; 

call info_orders(100, 150);
