-- rk3
CREATE TABLE IF NOT EXISTS employee
(
    id INT PRIMARY KEY,
    fio VARCHAR(32),
    date_of_birth DATE,
    department VARCHAR(32)
);

CREATE TABLE IF NOT EXISTS employee_attendance
(
    id INT PRIMARY KEY,
    employee_id INT,
    FOREIGN KEY (employee_id) REFERENCES employee(id),
    date DATE DEFAULT CURRENT_DATE,
    day_of_week VARCHAR,
    time TIME DEFAULT CURRENT_TIME,
    type INT
);

CREATE OR REPLACE FUNCTION count_employees() 
RETURNS int AS 
$$
DECLARE
    employee_count int;
BEGIN
    SELECT COUNT(*) INTO employee_count
    FROM employee
    WHERE date_of_birth <= CURRENT_DATE - INTERVAL '52 years'
    AND id IN (
        SELECT employee_id
        FROM employee_attendance
        GROUP BY employee_id
        HAVING COUNT(*) <= 3
    );

    RETURN employee_count;
END;
$$ LANGUAGE plpgsql;

-- req1
SELECT DISTINCT department
FROM employee
WHERE EXTRACT(MONTH FROM date_of_birth) = 5
AND id NOT IN (
    SELECT DISTINCT id
    FROM employee
    WHERE EXTRACT(MONTH FROM date_of_birth) <> 5
);

-- req2
SELECT fio
FROM employee e JOIN employee_attendance ea ON e.id = ea.employee_id
WHERE e.id IN (SELECT employee_id
			 FROM employee_attendance
			 GROUP BY employee_id
			 HAVING COUNT(type) = 2 -- вход выход
);

-- req3
SELECT DISTINCT fio
FROM employee e JOIN employee_attendance ea ON e.id = ea.employee_id
WHERE department = 'Бухгалтерия' and time = (SELECT MIN(time)
											  FROM employee_attendance
											  WHERE type = 1
											  GROUP BY id
											  HAVING time < '9:00'
											 );


