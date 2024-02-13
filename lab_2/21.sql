-- 21 --
delete from Passenger
where id in (select id
			 from Passenger 
			 where id > 500 and rating = 1.2);
