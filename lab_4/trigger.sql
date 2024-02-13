-- триггер
create or replace function update_order_price() 
returns trigger as
$$
    plpy.notice("Updated price for table Orders")
    plpy.notice("From %s to %s", TD["old"]["price"], TD["new"]["price"])
$$ language plpython3u;


create or replace trigger update_price_trigger 
after update on Orders
for each row execute 
procedure update_order_price();

update Orders
set price = 160
where id = 115;

select id, price
from Orders
where id = 115;
