-- 10 --
select id, name,
	case
		when rating < 1.5 then 'Terribly'
		when rating < 2.5 then 'Badly'
		when rating < 3.5 then 'Satisfactory'
		when rating < 4.5 then 'Well'
		else 'Excellent'
	end as driver_mark
from Driver;
