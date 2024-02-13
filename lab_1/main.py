from faker import Faker
from faker_vehicle import VehicleProvider
from random import choice, randint, uniform
import psycopg2

from config import DB_NAME, DB_HOST, DB_USER, DB_PWD

PASSENGER_FILE = "./data/passenger_info.csv"
DRIVER_FILE = "./data/driver_info.csv"
CAR_FILE = "./data/car_info.csv"
ORDERS_FILE = "./data/order_info.csv"

CREATE_SQL = "./sql/create_table.sql"
DROP_SQL = "./sql/drop_table.sql"
COPY_SQL = "./sql/copy_table.sql"
LIMITATIONS_SQL = "./sql/limitations.sql"

AMOUNT = 1000

CAR_NUMS = []


class DataBase:
    def __init__(self):
        try:
            self.__connection = psycopg2.connect(host=DB_HOST, user=DB_USER, password=DB_PWD, database=DB_NAME)
            self.__connection.autocommit = True
            self.__cursor = self.__connection.cursor()

            print("\nPostgreSQL: Connection opened\n")

        except Exception as error:
            print("\nError ocured while init. Exception: ", error)

    def __del__(self):
        if self.__connection:
            self.__cursor.close()
            self.__connection.close()

            print("\nPostgreSQL: Connection closed\n")

    def create_tables(self):
        try:
            f = open(CREATE_SQL, "r")
            str_execute = f.read()
            self.__cursor.execute(str_execute)

            f = open(LIMITATIONS_SQL, "r")
            str_execute = f.read()
            self.__cursor.execute(str_execute)

            print("\nSuccess: Tables are created\n")

        except Exception as error:
            print("\nError ocured while create. Exception: ", error)

    def drop_tables(self):
        try:
            f = open(DROP_SQL, "r")
            str_execute = f.read()

            self.__cursor.execute(str_execute)

            print("\nSuccess: Tables are dropped\n")

        except Exception as error:
            print("\nError ocured while delete. Exception: ", error)

    def copy_data(self):
        f = open(COPY_SQL, "r")
        str_execute = f.read()

        self.__cursor.execute(str_execute)


def generate_orders_info():
    global CAR_NUMS
    f = open(ORDERS_FILE, "w")

    faker = Faker()

    passenger_list = [i for i in range(1, AMOUNT + 1)]
    driver_list = [i for i in range(1, AMOUNT + 1)]

    for i in range(0, AMOUNT):
        passenger_id = choice(passenger_list)
        driver_id = choice(driver_list)
        car_num = choice(CAR_NUMS)
        order_date = faker.date()
        price = round(uniform(50.00, 5000), 2)

        line = "{0};{1};{2};{3};{4}\n".format(passenger_id, driver_id, car_num, order_date, price)

        f.write(line)

    print("Orders information created")

    f.close()


def generate_driver_info():
    f = open(DRIVER_FILE, "w")

    faker = Faker()
    tariff_list = ["Economy", "Comfort", "Comfort+", "Business", "Child", "Minivan", "Special"]

    for i in range(0, AMOUNT):
        name = faker.first_name()
        surname = faker.last_name()
        age = randint(18, 99)
        phone_number = faker.msisdn()
        experience = faker.date()[:4]
        rating = round(uniform(1.00, 5.00), 2)
        tariff = choice(tariff_list)
        line = "{0};{1};{2};{3};{4};{5};{6}\n".format(name, surname, age, phone_number, experience, rating, tariff)

        f.write(line)

    print("Driver information created")

    f.close()


def generate_passenger_info():
    f = open(PASSENGER_FILE, "w")
    faker = Faker()

    for i in range(0, AMOUNT):
        name = faker.first_name()
        surname = faker.last_name()
        rating = round(uniform(1.00, 5.00), 2)
        age = randint(14, 99)
        phone_number = faker.msisdn()

        line = "{0};{1};{2};{3};{4}\n".format(name, surname, rating, age, phone_number)

        f.write(line)

    print("Passenger information created")

    f.close()


def rand_car_number():
    global CAR_NUMS
    num = chr(randint(ord('A'), ord('Z'))) + \
          str(randint(0, 9)) + str(randint(0, 9)) + str(randint(0, 9)) + \
          chr(randint(ord('A'), ord('Z'))) + \
          chr(randint(ord('A'), ord('Z'))) + \
          str(randint(0, 9)) + str(randint(0, 9)) + str(randint(0, 9))
    CAR_NUMS.append(num)
    return num


def generate_car_info():
    f = open(CAR_FILE, "w")
    fuels = ["Gasoline", "Diesel", "Biodiesel", "Ethanol", "Compressed Natural Gas", "Liquified Petroleum Gas", "Hydrogen"]

    fake = Faker()
    fake.add_provider(VehicleProvider)

    for i in range(0, AMOUNT):
        num = rand_car_number()
        brand = fake.vehicle_make()
        mileage = randint(0, 1000000)
        release_year = fake.machine_year()
        gasoline = choice(fuels)

        line = "{0};{1};{2};{3};{4}\n".format(num, brand, mileage, release_year, gasoline)
        f.write(line)

    print("Car information created")

    f.close()


def main():
    database = DataBase()

    # database.drop_tables()
    database.create_tables()

    generate_car_info()
    generate_passenger_info()
    generate_driver_info()
    generate_orders_info()

    database.copy_data()


if __name__ == "__main__":
    main()
