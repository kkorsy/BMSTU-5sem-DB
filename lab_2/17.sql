-- 17 --
insert into Passenger (name, surname, rating, age, phone_number)
	select name, surname, rating, age + 25, phone_number
	from Passenger
	where rating = 4.6;
