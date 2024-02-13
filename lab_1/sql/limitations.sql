ALTER TABLE Passenger
ALTER COLUMN name SET NOT NULL,
ALTER COLUMN surname SET NOT NULL,
ALTER COLUMN rating SET NOT NULL,
ALTER COLUMN age SET NOT NULL,
ALTER COLUMN phone_number SET NOT NULL,
ADD check (name != ''),
ADD check (surname != ''),
ADD check (rating >= 1 and rating <= 5),
ADD check (age >= 14 and age <= 150);


ALTER TABLE Driver
ALTER COLUMN name SET NOT NULL,
ALTER COLUMN surname SET NOT NULL,
ALTER COLUMN age SET NOT NULL,
ALTER COLUMN phone_number SET NOT NULL,
ALTER COLUMN experience SET NOT NULL,
ALTER COLUMN rating SET NOT NULL,
ALTER COLUMN tariff SET NOT NULL,
ADD check (name != ''),
ADD check (surname != ''),
ADD check (age >= 18 and age <= 150),
ADD check (phone_number != ''),
ADD check (experience > 0),
ADD check (rating >= 1 and rating <= 5),
ADD check (tariff != '');


ALTER TABLE Car
ALTER COLUMN num SET NOT NULL,
ALTER COLUMN brand SET NOT NULL,
ALTER COLUMN mileage SET NOT NULL,
ALTER COLUMN release_year SET NOT NULL,
ALTER COLUMN gasoline SET NOT NULL,

ADD check (num != ''),
ADD check (brand != ''),
ADD check (mileage > 0),
ADD check (gasoline != ''),
ADD check (release_year >= 1800 and release_year <= 2023);


ALTER TABLE Orders
ALTER COLUMN order_date SET NOT NULL,
ALTER COLUMN price SET NOT NULL,
ADD check (price > 0);