EXPLAIN  
SELECT rental_id, customer_id, rental_date 
FROM rental 
WHERE rental_date > '2005-05-25'; 

EXPLAIN  
SELECT r.rental_id, c.first_name, c.last_name 
FROM rental r 
JOIN customer c ON r.customer_id = c.customer_id 
WHERE r.rental_date > '2005-05-25'; 

SELECT rental_id, customer_id 
FROM rental 
WHERE rental_date = '2005-05-25'; 

CREATE INDEX idx_rental_date ON rental (rental_date); 

SELECT c.first_name, c.last_name, r.rental_date 
FROM customer c 
JOIN rental r ON c.customer_id = r.customer_id 
WHERE r.rental_date > '2005-05-25'; 

CREATE INDEX idx_rental_date ON rental (rental_date); 

SELECT rental_id, customer_id  
FROM rental  
WHERE rental_date > '2005-05-25'; 

CREATE INDEX idx_customer_id ON rental (customer_id); 

CREATE INDEX idx_customer_rental_date ON rental (customer_id, rental_date); 

SELECT rental_id  
FROM rental  
WHERE customer_id = 5 AND rental_date > '2005-05-25'; 

SELECT rental_id, rental_date  
FROM rental  
WHERE customer_id = 5; 

CREATE INDEX idx_covering_rental ON rental (customer_id, rental_id, rental_date); 

PRAGMA index_list('rental') 

ANALYZE; 
REINDEX idx_convering_rental; -- Rebuild the index 
REINDEX rental; -- Rebuilds all indexes on rental 

SELECT r.rental_id, c.first_name, c.last_name  
FROM rental r JOIN customer c  
ON r.customer_id = c.customer_id  
WHERE r.rental_date > '2005-05-25'; 

CREATE INDEX idx_inventory_id ON rental (inventory_id); 

DROP INDEX idx_inventory_id ON rental; 

SELECT r.rental_id, c.first_name, c.last_name  
FROM rental r  
INNER JOIN customer c ON r.customer_id = c.customer_id; 

CREATE INDEX idx_rental_customer_id ON rental (customer_id);  

CREATE INDEX idx_customer_id ON customer (customer_id); 

SELECT r.rental_id, c.first_name, c.last_name  
FROM rental r  
INNER JOIN customer c ON r.customer_id = c.customer_id  
WHERE r.rental_date > '2005-05-25'; 

SELECT r.rental_id, c.first_name, c.last_name, i.film_id  
FROM rental r  
INNER JOIN customer c ON r.customer_id = c.customer_id  
INNER JOIN inventory i ON r.inventory_id = i.inventory_id; 

SELECT r.rental_id, c.first_name  
FROM rental r, customer c; 

SELECT r.rental_id, c.first_name  
FROM rental r INNER JOIN customer c ON r.customer_id = c.customer_id; 

EXPLAIN  
SELECT r.rental_id, c.first_name, c.last_name  
FROM rental r  
INNER JOIN customer c ON r.customer_id = c.customer_id; 

CREATE TEMPORARY TABLE temp_rentals AS  
    SELECT rental_id, customer_id  
    FROM rental WHERE rental_date > '2005-05-25'; 
    SELECT tr.rental_id, c.first_name, c.last_name  
    FROM temp_rentals tr  
    JOIN customer c ON tr.customer_id = c.customer_id; 

SELECT first_name, last_name  
FROM customer  
WHERE customer_id IN (  
    SELECT customer_id  
    FROM rental  
    WHERE rental_date > '2005-05-25' ); 

SELECT DISTINCT c.first_name, c.last_name  
FROM customer c JOIN rental r ON c.customer_id = r.customer_id  
WHERE r.rental_date > '2005-05-25'; 

SELECT first_name, last_name  
FROM customer c  
WHERE EXISTS (  
    SELECT 1  
    FROM rental r  
    WHERE r.customer_id = c.customer_id AND r.rental_date > '2005-05-25' ); 

SELECT DISTINCT c.first_name, c.last_name  
FROM customer c JOIN rental r ON c.customer_id = r.customer_id  
WHERE r.rental_date > '2005-05-25'; 

WITH RecentRentals AS (  
    SELECT customer_id  
    FROM rental  
    WHERE rental_date > '2005-05-25'  
)  
SELECT c.first_name, c.last_name  
FROM customer c JOIN RecentRentals rr  
ON c.customer_id = rr.customer_id; 

SELECT first_name, last_name  
FROM customer WHERE customer_id  
IN ( 
SELECT * FROM rental  
WHERE rental_date > '2005-05-25' ); 

SELECT first_name, last_name  
FROM customer  
WHERE customer_id IN (  
    SELECT customer_id  
    FROM rental WHERE rental_date > '2005-05-25' AND inventory_id IN  
    (  
        SELECT inventory_id  
        FROM inventory WHERE film_id = 1  
    )  
); 

SELECT DISTINCT c.first_name, c.last_name  
FROM customer c  
JOIN rental r ON c.customer_id = r.customer_id  
JOIN inventory i ON r.inventory_id = i.inventory_id  
WHERE r.rental_date > '2005-05-25' AND i.film_id = 1; 

CREATE INDEX idx_rental_date ON rental (rental_date); 

EXPLAIN  
    SELECT first_name, last_name  
    FROM customer  
    WHERE customer_id IN (  
        SELECT customer_id  
        FROM rental  
        WHERE rental_date > '2005-05-25'  
); 

SELECT *  
FROM rental  
WHERE rental_date > '2005-05-25'; 

SELECT rental_id, rental_date  
FROM rental  
WHERE rental_date > '2005-05-25'; 

SELECT rental_id, customer_id  
FROM rental  
WHERE rental_date > '2005-05-25'; 

CREATE INDEX idx_rental_date ON rental (rental_date); 

SELECT r.rental_id, c.first_name, c.last_name  
FROM rental r JOIN customer c ON r.customer_id = c.customer_id  
WHERE r.rental_date > '2005-05-25'; 

CREATE INDEX idx_rental_customer_id  
ON rental (customer_id);  

CREATE INDEX idx_customer_id  
ON customer (customer_id); 

EXPLAIN  
SELECT r.rental_id, c.first_name, c.last_name  
FROM rental r JOIN customer c ON r.customer_id = c.customer_id  
WHERE r.rental_date > '2005-05-25'; 

SELECT first_name, last_name  
FROM customer  
WHERE customer_id IN (  
    SELECT customer_id  
    FROM rental  
    WHERE rental_date > '2005-05-25'  
); 

SELECT DISTINCT c.first_name, c.last_name  
FROM customer c JOIN rental r ON c.customer_id = r.customer_id  
WHERE r.rental_date > '2005-05-25'; 

WITH RecentRentals AS (  
    SELECT customer_id  
    FROM rental  
    WHERE rental_date > '2005-05-25'  
)  
SELECT c.first_name, c.last_name  
FROM customer c  
JOIN RecentRentals rr ON c.customer_id = rr.customer_id; 

SELECT first_name, last_name  
FROM customer  
WHERE first_name LIKE '%John%'; 

SELECT first_name, last_name  
FROM customer  
WHERE first_name LIKE 'John%'; 

SELECT COUNT(*)  
FROM rental; 

SELECT COUNT(*)  
FROM rental  
WHERE rental_date > '2005-05-25'; 

EXPLAIN
SELECT *  
FROM film WHERE rental_rate > 2.99;