SELECT rental_id, customer_id,  
SUM(rental_rate) OVER () AS total_revenue 
FROM rental; 

SELECT customer_id, rental_id,  
SUM(rental_rate) OVER (PARTITION BY customer_id) AS customer_revenue 
FROM rental; 

SELECT category_id, title, rental_rate, 
RANK() OVER (PARTITION BY category_id ORDER BY rental_rate DESC) AS rank 
FROM film; 

SELECT customer_id, rental_id, rental_rate, 
SUM(rental_rate) OVER (PARTITION BY customer_id ORDER BY rental_date) AS running_total 
FROM rental; 

SELECT rental_id, rental_rate, 
AVG(rental_rate) OVER (ORDER BY rental_date ROWS 2 PRECEDING) AS moving_avg 
FROM rental; 

SELECT rental_id, rental_rate, 
LAG(rental_rate) OVER (ORDER BY rental_date) AS prev_rental_rate, 
rental_rate - LAG(rental_rate) OVER (ORDER BY rental_date) AS rate_difference 
FROM rental; 

SELECT customer_id, rental_id, rental_rate, 
RANK() OVER (PARTITION BY customer_id ORDER BY rental_rate DESC) AS rank, 
SUM(rental_rate) OVER (PARTITION BY customer_id) AS total_revenue, 
AVG(rental_rate) OVER (PARTITION BY customer_id) AS avg_rate 
FROM rental; 

WITH FilmRevenue AS ( 
    SELECT film_id, SUM(amount) AS total_revenue 
    FROM payment 
    GROUP BY film_id 
    ) 
SELECT f.title, fr.total_revenue 
FROM FilmRevenue fr 
JOIN film f ON fr.film_id = f.film_id; 

WITH FilmPopularity AS ( 
    SELECT film_id, COUNT(*) AS rental_count 
    FROM rental 
    GROUP BY film_id 
) 
SELECT f.title, fp.rental_count 
FROM FilmPopularity fp 
JOIN film f ON fp.film_id = f.film_id 
ORDER BY fp.rental_count DESC; 

WITH RECURSIVE EmployeeHierarchy AS ( 
    SELECT employee_id, manager_id, first_name, last_name 
    FROM employee 
    WHERE manager_id IS NULL -- Start with the top-level manager 
    UNION ALL 
    SELECT e.employee_id, e.manager_id, e.first_name, e.last_name 
    FROM employee e 
    JOIN EmployeeHierarchy eh ON e.manager_id = eh.employee_id 
) 
SELECT * 
FROM EmployeeHierarchy; 

WITH AverageDuration AS ( 
    SELECT AVG(DATEDIFF(return_date, rental_date)) AS avg_duration 
    FROM rental 
), 
LongRentals AS ( 
    SELECT f.title, DATEDIFF(r.return_date, r.rental_date) AS rental_duration 
    FROM rental r 
    JOIN film f ON r.inventory_id = f.inventory_id 
    WHERE DATEDIFF(r.return_date, r.rental_date) > (SELECT avg_duration FROM AverageDuration) 
) 
SELECT * 
FROM LongRentals; 

WITH CustomerRevenue AS ( 
    SELECT customer_id, SUM(amount) AS total_revenue 
    FROM payment 
    GROUP BY customer_id 
), 
RankedCustomers AS ( 
    SELECT customer_id, total_revenue, 
    RANK() OVER (ORDER BY total_revenue DESC) AS rank 
    FROM CustomerRevenue 
) 
SELECT * 
FROM RankedCustomers 
WHERE rank <= 10; 


WITH MonthlyActivity AS ( 
    SELECT customer_id,  
    EXTRACT(YEAR FROM rental_date) AS rental_year, 
    EXTRACT(MONTH FROM rental_date) AS rental_month, 
    COUNT(*) AS rental_count 
    FROM rental 
    GROUP BY customer_id, rental_year, rental_month 
), 
CustomerSummary AS ( 
    SELECT customer_id, rental_year, rental_month, rental_count, 
    RANK() OVER (PARTITION BY rental_year, rental_month ORDER BY rental_count DESC) AS rank 
    FROM MonthlyActivity 
) 
SELECT * 
FROM CustomerSummary 
WHERE rank <= 5; 

WITH RECURSIVE EmployeeHierarchy AS ( 
    -- Anchor query: Start with the top-level manager 
    SELECT employee_id, first_name, manager_id 
    FROM employee 
    WHERE manager_id IS NULL 
    UNION ALL 
    -- Recursive query: Retrieve employees reporting to the current level 
    SELECT e.employee_id, e.first_name, e.manager_id 
    FROM employee e 
    JOIN EmployeeHierarchy eh ON e.manager_id = eh.employee_id 
) 
SELECT * 
FROM EmployeeHierarchy; 


WITH RECURSIVE EmployeeHierarchy AS ( 
    SELECT employee_id, first_name, manager_id, 1 AS level 
    FROM employee 
    WHERE manager_id IS NULL 
    UNION ALL 
    SELECT e.employee_id, e.first_name, e.manager_id, eh.level + 1 
    FROM employee e 
    JOIN EmployeeHierarchy eh ON e.manager_id = eh.employee_id 
    WHERE eh.level < 3 
) 
SELECT * 
FROM EmployeeHierarchy; 

WITH RECURSIVE EmployeeHierarchy AS ( 
    SELECT employee_id, first_name, manager_id, CAST(employee_id AS CHAR) AS path 
    FROM employee 
    WHERE manager_id IS NULL 
    UNION ALL 
    SELECT e.employee_id, e.first_name, e.manager_id, CONCAT(eh.path, '->', e.employee_id) 
    FROM employee e 
    JOIN EmployeeHierarchy eh ON e.manager_id = eh.employee_id 
    WHERE NOT FIND_IN_SET(e.employee_id, eh.path) 
) 
SELECT * 
FROM EmployeeHierarchy; 

WITH RECURSIVE EmployeeHierarchy AS ( 
    SELECT employee_id, manager_id, 1 AS depth 
    FROM employee 
    WHERE manager_id IS NULL 
    UNION ALL 
    SELECT e.employee_id, e.manager_id, eh.depth + 1 
    FROM employee e 
    JOIN EmployeeHierarchy eh ON e.manager_id = eh.employee_id 
) 
SELECT manager_id, COUNT(*) AS total_employees 
FROM EmployeeHierarchy 
GROUP BY manager_id; 

BEGIN TRANSACTION; 
    INSERT INTO rental (rental_date, inventory_id, customer_id, staff_id) 
    VALUES ('2024-12-01', 1, 2, 1); 
    UPDATE inventory 
    SET quantity = quantity - 1 
    WHERE inventory_id = 1; 
COMMIT; 

SET TRANSACTION ISOLATION LEVEL REPEATABLE READ; 
BEGIN TRANSACTION; 
    SELECT * FROM rental 
    WHERE rental_date = '2024-12-01'; 
COMMIT; 

UPDATE inventory 
SET quantity = quantity - 1 
WHERE inventory_id = 1; 
COMMIT; 

UPDATE rental 
SET rental_rate = rental_rate * 1.1 
WHERE rental_id = 1 AND last_updated = '2024-12-01 10:00:00'; 

BEGIN TRANSACTION; 
    INSERT INTO rental (rental_date, inventory_id, customer_id, staff_id) 
    VALUES ('2024-12-01', 1, 2, 1); 
    SAVEPOINT after_rental; 
    UPDATE inventory 
    SET quantity = quantity - 1 
    WHERE inventory_id = 1; 
    ROLLBACK TO after_rental; 
COMMIT; 