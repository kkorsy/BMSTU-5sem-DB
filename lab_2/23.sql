-- 23 --
drop table if exists Family;

create table if not exists Family
(
	id serial primary key,
	id_child int,
	name varchar(255)
);

insert into Family(id_child, name)
values (4, 'Kate'), (5, 'Max'), (2, 'Daniel'), (3, 'Lizy'), (6, 'Bob'), (7, 'John');

select *
from Family;

with recursive RecFamily(id, id_child, name) as (
	select id, id_child, name
	from Family as F
	where F.id = 1
	
	union all
	select F.id, F.id_child, F.name
	from Family as F join RecFamily as rf on F.id = rf.id_child
)
select *
from RecFamily;
