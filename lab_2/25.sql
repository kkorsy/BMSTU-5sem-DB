-- 25 --
with otv as (
	select * 
	from Driver
	union all
	select * 
	from Driver 
),
delete_copy as
(
	select *, row_number() over (partition by id) as row_id
	from otv
)
select *
from delete_copy
where row_id = 1;