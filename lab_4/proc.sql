-- хранимая процедура
create or replace procedure update_driver_tariff_by_id(id int, tariff varchar) as 
$$
    prep = plpy.prepare("update Driver set tariff = $1 where id = $2", ["varchar", "int"])
    plpy.execute(prep, [tariff, id])
$$ 
language plpython3u;

call update_driver_tariff_by_id(115, 'Special');

select id, tariff
from Driver
where id = 115
