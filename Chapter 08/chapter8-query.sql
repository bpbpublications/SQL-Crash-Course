CREATE TABLE film_crew ( 
    crew_id INT PRIMARY KEY, 
    first_name VARCHAR(50), 
    last_name VARCHAR(50), 
    hire_date DATE 
); 

CREATE TABLE departments ( 
department_id INT PRIMARY KEY, 
department_name VARCHAR(100) 
); 

CREATE TABLE employees ( 
employee_id INT PRIMARY KEY, 
first_name VARCHAR(50), 
last_name VARCHAR(50), 
hire_date DATE, 
department_id INT, 
FOREIGN KEY (department_id) REFERENCES departments(department_id) 
); 

ALTER TABLE film_crew 
ADD email VARCHAR (100); 

ALTER TABLE film_crew 
MODIFY phone_number VARCHAR(15); 

ALTER TABLE film_crew 
DROP COLUMN nickname; 

ALTER TABLE film_crew 
ADD CONSTRAINT unique_email UNIQUE (email); 

ALTER TABLE film_crew 
RENAME TO crew_members; 

CREATE INDEX idx_last_name  
ON film_crew (last_name); 

CREATE INDEX idx_hire_date  
ON film_crew (hire_date); 

SELECT * FROM film_crew  
WHERE hire_date > '2020-01-01';  


CREATE INDEX idx_name  
ON film_crew (last_name, first_name); 

SELECT * FROM film_crew  
WHERE last_name = 'Smith'  
AND first_name = 'John'; 

EXPLAIN SELECT * FROM film_crew WHERE last_name = 'Doe'; 

ALTER INDEX idx_last_name REBUILD; 

DROP INDEX idx_last_name  
ON film_crew; 

CREATE UNIQUE INDEX idx_unique_email  
ON film_crew (email); 

CREATE VIEW crew_details AS 

SELECT fc.crew_id, fc.first_name, fc.last_name, d.department_name 
FROM film_crew fc 
JOIN departments d ON fc.department_id = d.department_id; 

SELECT * FROM crew_details; 

CREATE VIEW crew_rentals AS 
SELECT fc.crew_id, fc.first_name, fc.last_name, 
       COUNT(r.rental_id) AS total_rentals, 
       COUNT(r.rental_id) * fc.bonus_rate AS total_bonus 
FROM film_crew fc 
JOIN rental r ON fc.crew_id = r.staff_id  -- Assuming crew members are linked to rentals via staff_id 
GROUP BY fc.crew_id, fc.first_name, fc.last_name, fc.bonus_rate; 


SELECT * FROM crew_rentals; 

CREATE VIEW public_crew_details AS 
SELECT crew_id, first_name, last_name, department_id 
FROM film_crew; 

CREATE OR REPLACE VIEW crew_rentals AS 

SELECT fc.crew_id, fc.first_name, fc.last_name, 
       COUNT(r.rental_id) AS total_rentals, 
       COUNT(r.rental_id) * fc.new_bonus_rate AS total_bonus 
FROM film_crew fc 
JOIN rental r ON fc.crew_id = r.staff_id 
GROUP BY fc.crew_id, fc.first_name, fc.last_name, fc.new_bonus_rate; 

CREATE VIEW rental_summary AS 
SELECT r.rental_id, c.first_name || ' ' || c.last_name AS customer_name, 
       f.title AS film_title, r.rental_date, r.return_date 
FROM rental r 
JOIN customer c ON r.customer_id = c.customer_id 
JOIN inventory i ON r.inventory_id = i.inventory_id 
JOIN film f ON i.film_id = f.film_id; 

SELECT * FROM rental_summary WHERE rental_date > '2005-01-01'; 
CREATE PROCEDURE UpdateCrewBonuses AS 
BEGIN 
    UPDATE film_crew 
    SET bonus = bonus * 1.15 
    WHERE performance_level = 'Outstanding'; 

    UPDATE film_crew 
    SET bonus = bonus * 1.10 
    WHERE performance_level = 'Exceeds Expectations'; 

    UPDATE film_crew 
    SET bonus = bonus * 0.90 
    WHERE performance_level = 'Needs Improvement'; 
END; 

EXEC UpdateCrewBonuses; 

CREATE PROCEDURE UpdateCrewBonuses 
    @PercentIncrease DECIMAL(5, 2) 
AS 
BEGIN 
    UPDATE film_crew 
    SET bonus = bonus * (1 + @PercentIncrease / 100) 
    WHERE performance_level = 'Outstanding'; 

    UPDATE film_crew 
    SET bonus = bonus * (1 + (@PercentIncrease / 100) / 2) 
    WHERE performance_level = 'Exceeds Expectations'; 

    UPDATE film_crew 
    SET bonus = bonus * (1 - (@PercentIncrease / 100) / 2) 
    WHERE performance_level = 'Needs Improvement'; 
END; 

EXEC UpdateCrewBonuses @PercentIncrease = 10; 

CREATE FUNCTION CalculateAnnualBonus 
(@MonthlyBonus DECIMAL(10, 2)) 
RETURNS DECIMAL(10, 2) 
AS 
BEGIN 
    RETURN @MonthlyBonus * 12; 
END; 

SELECT crew_id, first_name, last_name,  
       CalculateAnnualBonus(bonus) AS annual_bonus 
FROM film_crew; 

CREATE FUNCTION GetCrewByDepartment 
(@DepartmentID INT) 
RETURNS TABLE 
AS 
RETURN  
( 
    SELECT crew_id, first_name, last_name 
    FROM film_crew 
    WHERE department_id = @DepartmentID 
); 

SELECT * FROM GetCrewByDepartment(2); 

CREATE TRIGGER log_crew_insert 
AFTER INSERT ON film_crew 
FOR EACH ROW 
BEGIN 
    INSERT INTO crew_log (crew_id, action, action_date) 
    VALUES (NEW.crew_id, 'INSERT', CURRENT_TIMESTAMP); 
END; 

CREATE TRIGGER check_crew_hire_date 
BEFORE INSERT ON film_crew 
FOR EACH ROW 
BEGIN 
    IF NEW.hire_date > CURRENT_DATE THEN 
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Hire date cannot be in the future'; 
    END IF; 
END; 

CREATE TRIGGER update_department_count_after_insert 
AFTER INSERT ON film_crew 
FOR EACH ROW 
BEGIN 
    UPDATE departments 
    SET crew_count = crew_count + 1 
    WHERE department_id = NEW.department_id; 
END; 

CREATE TRIGGER update_department_count_after_delete 
AFTER DELETE ON film_crew 
FOR EACH ROW 
BEGIN 
    UPDATE departments 
    SET crew_count = crew_count - 1 
    WHERE department_id = OLD.department_id; 
END; 

CREATE TRIGGER audit_bonus_changes 
AFTER UPDATE ON film_crew 
FOR EACH ROW 
BEGIN 
    IF OLD.bonus <> NEW.bonus THEN 
        INSERT INTO bonus_audit (crew_id, old_bonus, new_bonus, change_date) 
        VALUES (NEW.crew_id, OLD.bonus, NEW.bonus, CURRENT_TIMESTAMP); 
    END IF; 
END; 

CREATE TRIGGER prevent_department_deletion 
BEFORE DELETE ON departments 
FOR EACH ROW 
BEGIN 
    DECLARE crew_count INT; 
    SELECT COUNT(*) INTO crew_count 
    FROM film_crew 
    WHERE department_id = OLD.department_id; 

    IF crew_count > 0 THEN 
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Cannot delete department with assigned crew members'; 
    END IF; 
END; 

CREATE TABLE rental_log ( 
    log_id INTEGER PRIMARY KEY AUTOINCREMENT, 
    rental_id INTEGER, 
    customer_id INTEGER, 
    log_date TEXT 
); 

ALTER TABLE rental_log 
ADD COLUMN notes TEXT; 

DROP TABLE rental_log; 

CREATE INDEX idx_film_title ON film (title);

EXPLAIN QUERY PLAN SELECT * FROM film WHERE title = 'ACADEMY DINOSAUR'; 

DROP INDEX idx_film_title; 

CREATE VIEW rental_summary AS 
    SELECT r.rental_id, c.customer_id, f.title, r.rental_date 
    FROM rental r 
    JOIN customer c ON r.customer_id = c.customer_id 
    JOIN inventory i ON r.inventory_id = i.inventory_id 
    JOIN film f ON i.film_id = f.film_id;

SELECT * FROM rental_summary WHERE rental_date > '2005-01-01';

DROP VIEW rental_summary; 

CREATE TABLE customer_revenue ( 
    customer_id INTEGER PRIMARY KEY, 
    monthly_revenue REAL 
);

SELECT customer_id, monthly_revenue * 12 AS annual_revenue 
FROM customer_revenue;

ALTER TABLE customer_revenue 
ADD COLUMN annual_revenue REAL; 

UPDATE customer_revenue 
SET annual_revenue = monthly_revenue * 12;

CREATE TRIGGER log_rental_insert 
AFTER INSERT ON rental 
BEGIN 
    INSERT INTO rental_log (rental_id, customer_id, log_date) 
    VALUES (NEW.rental_id, NEW.customer_id, DATETIME('now')); 
END;

INSERT INTO rental (rental_id, customer_id, inventory_id, rental_date) 
VALUES (1, 2, 3, '2023-11-01'); 

SELECT * FROM rental_log;

DROP TRIGGER log_rental_insert; 