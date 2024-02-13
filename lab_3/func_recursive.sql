-- рекурсивная функция
drop table if exists tempNames;
	
create table tempNames
(
	id serial primary key,
	id_on int,
	name varchar(128)
);

insert into tempNames(id_on, name) values
(3, 'Liza'),
(6, 'Richard'),
(5, 'Daniel'),
(2, 'Anna'),
(4, 'Mary');

create or replace function print_recursive(n_begin int)
returns table (id int,
			   id_on int,
			   name varchar) as
$$
begin
	return query
	
	with recursive recNames(id, id_on, name) as
	(
		select tn.id, tn.id_on, tn.name
		from tempNames tn
		where tn.id = n_begin
		union all
		select tn.id, tn.id_on, tn.name
		from tempNames tn join recNames as rn on tn.id = rn.id_on
	)
	select *
	from recNames;

end;
$$ language plpgsql;

select *
from print_recursive(1);