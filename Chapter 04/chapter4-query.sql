SELECT title, release_year 
FROM film;

SELECT title, release_year 
FROM film 
WHERE title = 'WONDERFUL DROP';

SELECT COUNT(*) 
FROM film 
WHERE release_year = '2006';

INSERT INTO actor (actor_id, first_name, last_name, last_update)  
VALUES (1000, 'Chris', 'Banner', 08-19-2026);

UPDATE actor 
SET first_name = 'Peter' 
WHERE last_name = 'Banner';

DELETE FROM actor 
WHERE actor_id = 1000;

CREATE TABLE store_employees ( 
    employee_id INT PRIMARY KEY, 
    first_name VARCHAR(50), 
    last_name VARCHAR(50), 
    hire_date DATE, 
    department VARCHAR(50), 
    salary DECIMAL(10, 2) 
);

ALTER TABLE store_employees 
ADD last_updated DATE;

DROP TABLE store_employees;

SELECT first_name, last_name  
FROM actor; 

SELECT * 
FROM actor;

SELECT first_name, last_name  
FROM customer  
WHERE active = 1;

SELECT first_name, last_name 
FROM customer 
ORDER BY last_name ASC;

SELECT first_name, last_name, active 
FROM customer 
ORDER BY last_name ASC, active DESC;

SELECT title, rating 
FROM film 
LIMIT 10;

SELECT rating, COUNT(*) 
FROM film 
GROUP BY rating;

SELECT DISTINCT rating 
FROM film;

SELECT title, release_year  
FROM film  
WHERE rating IN (SELECT rating FROM film WHERE rating = 'PG');

SELECT a.title, b.name 
FROM film a 
INNER JOIN language b ON a.language_id = b.language_id;

SELECT staff.first_name, staff.last_name, store.manager_staff_id 
FROM staff 
LEFT JOIN store ON staff.staff_id = store.manager_staff_id;

SELECT store.manager_staff_id, staff.first_name, staff.last_name 
FROM staff 
RIGHT JOIN store ON store.manager_staff_id = staff.staff_id;

SELECT store.manager_staff_id, staff.first_name, staff.last_name 
FROM staff 
FULL JOIN store ON store.manager_staff_id = staff.staff_id;

SELECT title, length 
FROM film 
WHERE title = 'WYOMING STORM';

SELECT title, length 
FROM film 
WHERE length > 180;

SELECT title, length 
FROM film 
WHERE rental_rate = 4.99 AND length > 180;

SELECT title, length 
FROM film 
WHERE rental_rate = 4.99 OR length > 180;

SELECT title, release_year 
FROM film 
WHERE NOT title = 'FRONTIER CABIN';

SELECT title, release_year 
FROM film 
WHERE title LIKE 'A%'; 

SELECT title, rental_rate 
FROM film 
WHERE rental_rate IN (0.99, 2.99); 

SELECT title, length 
FROM film 
WHERE length BETWEEN 90 AND 180; 

SELECT title, rating 
FROM film 
ORDER BY rating; 

SELECT title, rating 
FROM film 
ORDER BY rating DESC;

SELECT title, rating, rental_rate 
FROM film 
ORDER BY rating ASC, rental_rate DESC;

SELECT title, rating 
FROM film 
ORDER BY LENGTH(title); 

SELECT customer_id,(JULIANDAY(return_date)-JULIANDAY(rental_date) +1) AS rental_length_days 
FROM rental 
ORDER BY rental_length_days DESC; 

SELECT customer_id, COUNT(*) 
FROM rental 
GROUP BY customer_id 
ORDER BY COUNT(*) DESC; 

SELECT title, release_year 
FROM film 
ORDER BY title DESC 
LIMIT 10; 

SELECT title, release_year 
FROM film 
LIMIT 10; 

SELECT title, release_year 
FROM film 
ORDER BY title DESC 
LIMIT 5; 

SELECT title, release_year 
FROM film 
LIMIT 5 OFFSET 10; 

SELECT title, release_year 
FROM film 
LIMIT 10, 5; 

SELECT first_name, last_name, email, active  
FROM customers; 

SELECT payment_id, customer_id, rental_id, amount  
FROM payments; 

SELECT customer_id, first_name, last_name, email, active  
FROM customer  
WHERE first_name = 'BILL' AND last_name = 'GAVIN';

SELECT payment_id, customer_id, amount  
FROM payment  
WHERE customer_id = 457; 

SELECT active, COUNT(customer_id)  
FROM customer GROUP BY active  
ORDER BY active;

SELECT COUNT(payment_id) as 'number_of_sales'  
FROM payment where customer_id = 457; 

SELECT customer_id, first_name, last_name, email 
FROM customer 
LIMIT 5;

SELECT customer_id, first_name, last_name, email 
FROM customer 
WHERE active = 0 
LIMIT 5;

SELECT customer.*, payment.* FROM customer 
INNER JOIN payment 
ON customer.customer_id = payment.customer_id 
WHERE customer.customer_id = 457;

SELECT first_name, last_name, SUM(amount) as 'sales'  
FROM customer 
INNER JOIN payment 
ON customer.customer_id = payment.customer_id 
WHERE customer.customer_id = 457;

SELECT rental.rental_id, 
(SELECT amount FROM payment WHERE rental_id = rental.rental_id)  as 'amount' 
FROM rental  
INNER JOIN customer ON rental.customer_id = customer.customer_id 
WHERE customer.customer_id = 457; 
