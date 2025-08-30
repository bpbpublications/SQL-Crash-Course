INSERT INTO actor (actor_id, first_name, last_name) 
VALUES (1000, 'Penelope', 'Jones') 

INSERT INTO actor (first_name, last_name) 
VALUES ('Penelope', 'Jones'); 

INSERT INTO actor (actor_id, first_name, last_name) 
VALUES 
(1001, 'Monica', 'Jones'), 
(1002, 'Sophia', 'Swift'), 
(1003, 'Jennifer', 'Smith'); 

INSERT INTO actor_backup_table (actor_id, first_name, last_name) 
SELECT actor_id, first_name, last_name 
FROM actor;

INSERT INTO actor_backup_table (actor_id, first_name, last_name) 
SELECT actor_id, first_name, last_name 
FROM actor 
WHERE actor_id = 1000; 

BEGIN TRANSACTION; 

INSERT INTO actor (actor_id, first_name, last_name) 
VALUES (1000, 'Sophia', 'Swift'); 

INSERT INTO film_actor (actor_id, film_id) 
VALUES (1000, 300); 

-- Additional insert operations can go here 

COMMIT; 

UPDATE film 
SET rental_rate = 4.99 
WHERE film_id = 101; 

UPDATE film 
SET rental_rate = 5.99, rating = 'PG-13' 
WHERE film_id = 102;

UPDATE film 
SET rental_rate = rental_rate * 1.05 
WHERE film_id IN ( 
    SELECT film_id 
    FROM film_category 
    JOIN category ON film_category.category_id = category.category_id 
    WHERE category.name = 'Action' 
);

UPDATE film 
SET rental_rate = CASE   
    WHEN rental_rate < 2.99 THEN rental_rate * 1.10 
    WHEN rental_rate BETWEEN 2.99 AND 4.99 THEN rental_rate * 1.07 
    ELSE rental_rate * 1.05 
END;

UPDATE film 
SET rental_rate = rental_rate + ( 
    SELECT bonus_rate FROM film_performance 
    WHERE film_performance.film_id = film.film_id 
) 
WHERE EXISTS ( 
    SELECT 1 FROM film_performance 
    WHERE film_performance.film_id = film.film_id 
); 

BEGIN; 

UPDATE film 
SET rental_rate = rental_rate * 1.05 
WHERE film_id IN ( 
    SELECT film_id 
    FROM film_category 
    JOIN category ON film_category.category_id = category.category_id 
    WHERE category.name = 'Drama' 
); 

UPDATE film 
SET rental_rate = rental_rate * 1.03 
WHERE film_id IN ( 
    SELECT film_id 
    FROM film_category 
    JOIN category ON film_category.category_id = category.category_id 
    WHERE category.name = 'Comedy' 
); 

COMMIT; 

DELETE FROM film 
WHERE film_id = 123;

DELETE FROM film 
WHERE film_id IN ( 
    SELECT film_id 
    FROM rental 
    WHERE rental_date < DATE_SUB(CURDATE(), INTERVAL 1 YEAR) 
); 

SELECT * 
FROM film 
WHERE film_id IN ( 
    SELECT film_id 
    FROM rental 
    WHERE rental_date < DATE_SUB(CURDATE(), INTERVAL 1 YEAR) 
);

DELETE FROM rental 
WHERE customer_id NOT IN (SELECT customer_id FROM customer);

ALTER TABLE rental 
ADD CONSTRAINT fk_customer 
FOREIGN KEY (customer_id) REFERENCES customer(customer_id) 
ON DELETE CASCADE;

BEGIN; 

DELETE FROM customer 
WHERE last_update < DATE_SUB(CURDATE(), INTERVAL 1 YEAR); 

DELETE FROM rental 
WHERE customer_id NOT IN (SELECT customer_id FROM customer); 

COMMIT;

INSERT INTO film (film_id, title, description, special_features) 
VALUES (101, 'Mystery Movie', 'An exciting thriller with unknown twists', NULL);

UPDATE film 
SET replacement_cost = NULL 
WHERE film_id = 101;

UPDATE film 
SET rating = 'Unrated' 
WHERE rating IS NULL; 

DELETE FROM film 
WHERE description IS NULL AND special_features IS NULL; 

INSERT INTO actor (actor_id, first_name, last_name)  
VALUES (201, 'Alex', 'Green');

INSERT INTO film (film_id, title, description, rental_rate)  
VALUES (1001, 'Tech Thriller', 'A suspenseful tech drama', 3.99);

INSERT INTO customer (customer_id, first_name, last_name, email)  
VALUES (601, 'Taylor', 'Smith', NULL); 

UPDATE actor  
SET last_name = 'Brown'  
WHERE actor_id = 201; 

UPDATE film  
SET rental_rate = rental_rate * 1.10  
WHERE rental_rate < 3.00; 

UPDATE customer  
SET last_update = CURRENT_TIMESTAMP  
WHERE customer_id = 601; 

DELETE FROM film  
WHERE film_id = 1001; 

DELETE FROM actor  
WHERE last_name = 'Doe';

DELETE FROM customer  
WHERE email IS NULL AND address_id IS NULL;

UPDATE film  
SET description = 'Description unavailable'  
WHERE description IS NULL; 

INSERT INTO customer (customer_id, first_name, last_name, email)  
VALUES (602, 'Jordan', 'Lee', NULL); 

DELETE FROM actor  
WHERE first_name IS NULL AND last_name IS NULL; 