COPY Passenger(name, surname, rating, age, phone_number) from 'D:/DB/lab_1/data/passenger_info.csv' delimiter ';';

COPY Driver(name, surname, age, phone_number, experience, rating, tariff) from 'D:/DB/lab_1/data/driver_info.csv' delimiter ';';

COPY Car(num, brand, mileage, release_year, gasoline) from 'D:/DB/lab_1/data/car_info.csv' delimiter ';';

COPY Orders(passenger_id, driver_id, car_num, order_date, price) from 'D:/DB/lab_1/data/order_info.csv' delimiter ';';