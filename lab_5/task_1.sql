-- извлечь данные в JSON

COPY(select row_to_json(cr) from Car cr) TO 'D:/DB/lab_5/car.json';
COPY(select row_to_json(dr) from Driver dr) TO 'D:/DB/lab_5/driver.json';
COPY(select row_to_json(pas) from Passenger pas) TO 'D:/DB/lab_5/passenger.json';
COPY(select row_to_json(ord) from Orders ord) TO 'D:/DB/lab_5/orders.json';