-- рекурсивная хранимая процедура
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
(NULL, 'Mary');

create or replace procedure recursive_print(n_begin int) as
$$
declare
	next_id int;
	cur_name varchar;
begin
	select tn.id_on, tn.name
	from tempNames tn
	where tn.id = n_begin
	into next_id, cur_name;
	
	raise notice 'Current name - %', cur_name;
	
	if next_id is NULL then
		raise notice 'End of recursion';
	else
		call recursive_print(next_id);
	end if;
end;
$$ language plpgsql;

call recursive_print(1);
