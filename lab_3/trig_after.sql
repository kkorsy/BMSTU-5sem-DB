-- триггер AFTER

create or replace function update_info()
returns trigger as
$$
begin
    raise notice 'Update: Information was successfully updated';
    return new;
end;
$$ language plpgsql;

create or replace trigger update_trigger 
after update on Orders
for each row
execute procedure update_info();

update Orders
set price = price + 100
where price < 100;
