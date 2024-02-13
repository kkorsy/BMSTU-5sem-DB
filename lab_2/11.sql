-- 11 --
drop if exists temp_table;

select surname
into temp_table
from Passenger
order by surname;
