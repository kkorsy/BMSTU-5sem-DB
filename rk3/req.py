req1 = '''
SELECT DISTINCT department
FROM employee
WHERE EXTRACT(MONTH FROM date_of_birth) = 5
AND id NOT IN (
    SELECT DISTINCT id
    FROM employee
    WHERE EXTRACT(MONTH FROM date_of_birth) <> 5
);
'''

req2 = '''
SELECT fio
FROM employee e JOIN employee_attendance ea ON e.id = ea.employee_id
WHERE e.id IN (SELECT employee_id
               FROM employee_attendance
               GROUP BY employee_id
               HAVING COUNT(type) = 2
);
'''

req3 = '''
SELECT DISTINCT fio
FROM employee e JOIN employee_attendance ea ON e.id = ea.employee_id
WHERE department = \'Бухгалтерия\' and time = (SELECT MIN(time)
                                             FROM employee_attendance
                                             WHERE type = 1
                                             GROUP BY id
                                             HAVING time < \'9:00\'
                                             );
'''