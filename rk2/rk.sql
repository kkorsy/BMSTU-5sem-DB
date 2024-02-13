-- rk2
create table if not exists excursion
(
	id int primary key,
	name varchar(256),
	description varchar(256),
	opened date,
	closed date
);

create table if not exists stand
(
	id int primary key,
	name varchar(256),
	subject varchar(256),
	description varchar(256)
);

create table if not exists visitor
(
	id int primary key,
	fio varchar(256),
	address varchar(256),
	phone varchar(11)
);

create table if not exists excursion_stand
(
	id_excursion int,
	foreign key (id_excursion) references excursion(id),
	id_stand int,
	foreign key (id_stand) references stand(id)
);

create table if not exists excursion_visitor
(
	id_excursion int,
	foreign key (id_excursion) references excursion(id),
	id_visitor int,
	foreign key (id_visitor) references visitor(id)
);

insert into excursion (id, name, description, opened, closed) values 
(
	(1, 'Moscow', 'City Tour', '2022-06-01', '2022-06-07'),
	(2, 'Hermitage', 'Museum Visit', '2021-06-10', '2021-06-15'),
	(3, 'Historical Walk', 'Ancient city', '2020-07-01', '2020-07-07'),
	(4, 'Pictures', 'Art Gallery Tour', '2019-07-10', '2019-07-15'),
	(5, 'Forest', 'Nature Walk', '2018-08-01', '2018-08-07'),
	(6, 'BMSTU', 'Architecture', '2017-08-10', '2017-08-15'),
	(7, 'Ship', 'Night Cityscape', '2016-09-01', '2016-09-07'),
	(8, 'Park', 'Botanical Garden Visit', '2015-09-10', '2015-09-15'),
	(9, 'a', 'Cultural Tour', '2014-10-01', '2014-10-07'),
	(10, 'Extra', 'Dop excursion', '2013-10-10', '2013-10-15')
);

insert into stand (id, name, subject, description) values 
(
	(1, 'Science', 'Physics', 'descr 1'),
	(2, 'Artifacts', 'History', 'descr 2'),
	(3, 'Exhibit', 'Biology', 'descr 3'),
	(4, 'Space', 'Astronomy', 'descr 4'),
	(5, 'Art', 'Art', 'descr 5'),
	(6, 'Botanic', 'Botany', 'descr 6'),
	(7, 'Culture', 'Anthropology', 'descr 7'),
	(8, 'Ocean', 'Biology', 'descr 8'),
	(9, 'Tech', 'Technology', 'descr 9'),
	(10, 'Civilization', 'Archaeology', 'descr 10')
);

insert into visitor (id, fio, address, phone) values 
(
	(1, 'John Smith', '123 Main Street, Anytown', '123-456-7890'),
	(2, 'Emma Johnson', '456 Elm Avenue, Othertown', '234-567-8901'),
	(3, 'Michael Williams', '789 Oak Lane, Anycity', '345-678-9012'),
	(4, 'Sophia Brown', '789 Pine Road, Newcity', '456-789-0123'),
	(5, 'William Taylor', '567 Cedar Street, Sometown', '567-890-1234'),
	(6, 'Olivia Martinez', '890 Maple Drive, Othertown', '678-901-2345'),
	(7, 'James Jones', '234 Birch Court, Anycity', '789-012-3456'),
	(8, 'Emily Garcia', '345 Elm Street, Newcity', '890-123-4567'),
	(9, 'Alexander Rodriguez', '901 Oak Avenue, Sometown', '901-234-5678'),
	(10, 'Mia Hernandez', '678 Pine Lane, Sometown', '012-345-6789')
);

insert into excursion_stand (id_excursion, id_stand) values 
(
	(1, 1),
	(2, 5),
	(3, 7),
	(4, 2),
	(5, 4),
	(6, 3),
	(7, 10),
	(8, 9),
	(9, 8),
	(10, 6)
);

insert into excursion_visitor (id_excursion, id_visitor) values 
(
	(1, 3),
	(2, 4),
	(3, 5),
	(4, 1),
	(5, 6),
	(6, 7),
	(7, 2),
	(8, 8),
	(9, 6),
	(10, 9)
);

-- 1
-- вывести id, описание экскурсии, у которой есть стенд
select id, description
from excursion
where exists (select id_excursion 
				from excursion_stand);


-- 2
-- вывести id, описание и количество посетителей экскурсии
select id, description, (select count(*) 
						 from excursion_visitor 
						 where id_excursion = excursion.id) 
						 as visitor_count
from excursion;

-- 3
-- вывести описание, дату открытия и закрытия экскурсии, дата открытия которой между 01.01.2020 и 31.12.2023
select description, opened, closed
from excursion
where opened between '2020-01-01' and '2023-12-31';


create or replace function getScalarFunctionsCount(out function_count INT)
returns setof RECORD as $$
declare
    function_name TEXT;
    function_args TEXT;
begin
    function_count := 0;
    for function_name, function_args in
        select proname as function_name,
               pg_get_function_identity_arguments(p.oid) as function_arguments
        from pg_proc p
        join pg_namespace n on n.oid = p.pronamespace
        where n.nspname = 'public' and pg_proc.pronargs = 0
    loop
        if function_args != '' then
            function_count := function_count + 1;
            return next (function_name || ' ' || function_args);
        end if;
    end loop;
    return;
end;
$$ LANGUAGE plpgsql;