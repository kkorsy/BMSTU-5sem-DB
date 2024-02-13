CREATE TABLE if not exists Passenger
(
    id 				serial PRIMARY KEY,
    name            varchar(255),
    surname         varchar(255),
    rating          float,
    age             int,
    phone_number    varchar(13)
);


CREATE TABLE if not exists Driver
(
    id              serial PRIMARY KEY,
    name            varchar(255),
    surname         varchar(255),
    age             int,
    phone_number    varchar(13),
    experience      int,
    rating          float,
    tariff          varchar(255)
);


CREATE TABLE if not exists Car
(
    num             varchar(9) PRIMARY KEY,
    brand           varchar(255),
    mileage         int,
    release_year    int,
    gasoline        varchar(255)
);


CREATE TABLE if not exists Orders
(
    id              serial PRIMARY KEY,
    passenger_id    serial REFERENCES Passenger(id) ON DELETE CASCADE,
    driver_id       serial REFERENCES Driver(id) ON DELETE CASCADE,
    car_num         varchar REFERENCES Car(num) ON DELETE CASCADE,
    order_date      date,
    price           float
);