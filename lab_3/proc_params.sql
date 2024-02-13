-- хранимая процедура с параметрами
select id, order_date, price
from Orders
where order_date = '1978-03-22';

create or replace procedure add_order_price(ord_date date, add_price int) as
$$
begin
	update Orders
	set price = price + add_price
	where order_date = ord_date;
end;
$$ language plpgsql;

call add_order_price('1972-06-19', 150);

select id, order_date, price
from Orders
where order_date = '1972-06-19';
