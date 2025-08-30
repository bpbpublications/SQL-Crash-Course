SELECT *
FROM film;

SELECT *
FROM customer;

SELECT first_name, last_name
FROM actor;

SELECT first_name, last_name 
FROM customer 
WHERE active = 0;

-- This is a single-line comment
SELECT first_name, last_name /* This is a multi-line comment */
FROM customer 
WHERE active = 0;

CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    hire_date DATE,
    department VARCHAR(50),
    salary DECIMAL(10, 2)
);
INSERT INTO employees (employee_id, first_name, last_name, hire_date, department, salary) 
VALUES (1, 'John', 'Doe', '2022-01-15', 'Engineering', 75000.00);

INSERT INTO employees (employee_id, first_name, last_name, hire_date, department, salary) 
VALUES (2, 'Jane', 'Smith', '2021-11-22', 'Marketing', 65000.00);

INSERT INTO employees (employee_id, first_name, last_name, hire_date, department, salary) 
VALUES (3, 'Michael', 'Johnson', '2023-03-05', 'Sales', 55000.00);

INSERT INTO employees (employee_id, first_name, last_name, hire_date, department, salary) 
VALUES (4, 'Emily', 'Davis', '2020-07-18', 'IT', 60000.00);

INSERT INTO employees (employee_id, first_name, last_name, hire_date, department, salary) 
VALUES (5, 'David', 'Miller', '2019-02-25', 'IT', 70000.00);

INSERT INTO employees (employee_id, first_name, last_name, hire_date, department, salary) 
VALUES (6, 'Sarah', 'Wilson', '2023-06-10', 'Customer Support', 48000.00);

INSERT INTO employees (employee_id, first_name, last_name, hire_date, department, salary) 
VALUES (7, 'Christopher', 'Brown', '2021-09-30', 'Product Development', 80000.00);

INSERT INTO employees (employee_id, first_name, last_name, hire_date, department, salary) 
VALUES (8, 'Jessica', 'Garcia', '2022-04-19', 'Engineering', 77000.00);

INSERT INTO employees (employee_id, first_name, last_name, hire_date, department, salary) 
VALUES (9, 'Matthew', 'Martinez', '2020-12-12', 'Legal', 90000.00);

INSERT INTO employees (employee_id, first_name, last_name, hire_date, department, salary) 
VALUES (10, 'Amanda', 'Rodriguez', '2023-07-07', 'Engineering', 65000.00);

SELECT first_name, last_name, salary
FROM employees
WHERE salary > 50000 AND department = 'IT';
