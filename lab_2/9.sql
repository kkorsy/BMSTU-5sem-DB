-- 09 --
select num, brand,
	case release_year
		when extract('year' from current_date) then 'this year'
		when extract('year' from current_date) - 1 then 'last year'
		else cast(extract('year' from current_date) - release_year as varchar(5)) || cast(' years ago' as varchar(10))
	end as which_year
from Car;
