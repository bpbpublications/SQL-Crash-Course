SELECT CONCAT(first_name, ' ', last_name) AS full_name 
FROM customer; 

SELECT CONCAT('The rental cost for "', title, '" is $', rental_rate) AS rental_message 
FROM film; 

SELECT first_name, SUBSTRING(first_name, 1, 3) AS short_name 
FROM customer; 

SELECT  
UPPER(first_name) AS first_name_upper,  
UPPER(last_name) AS last_name_upper 
FROM customer; 

SELECT TRIM(first_name) AS trimmed_first_name 
FROM customer; 

SELECT LPAD(customer_id, 5, '0') AS padded_customer_id 
FROM customer; 

SELECT title, REPLACE(description, 'rental', 'lease') AS updated_description 
FROM film; 

SELECT  
title,  
POSITION('action' IN description) AS action_position 
FROM film; 

SELECT first_name, last_name 
FROM customer 
WHERE first_name REGEXP '[0-9]'; 


SELECT CONCAT(UPPER(TRIM(first_name)), '_', UPPER(TRIM(last_name)), '_ID', customer_id) AS customer_identifier 
FROM customer; 


SELECT rental_id, rental_rate, duration, rental_rate * duration AS total_revenue 
FROM rental; 

SELECT SUM(rental_rate * duration) AS total_revenue 
FROM rental; 

SELECT AVG(rental_rate) AS average_rental_rate 
FROM rental; 

CREATE TABLE financials ( 
    amount DECIMAL(10, 2) 
); 

SELECT ROUND(rental_rate * duration, 2) AS rounded_revenue 
FROM rental; 

SELECT rental_id, 
       CASE 
           WHEN duration > 0 THEN rental_rate / duration 
           ELSE 0 
       END AS price_per_minute 
FROM rental; 

SELECT 
rental_id, 
rental_rate + COALESCE(discount, 0) AS adjusted_rate 
FROM rental;

SELECT rental_id, SQRT(duration) AS sqrt_duration 
FROM rental; 

SELECT rental_id, MOD(rental_id, 2) AS is_odd 
FROM rental; 

SELECT FORMAT(rental_rate, 2) AS formatted_rate 
FROM rental; 

SELECT rental_id, 
    ROUND((rental_rate * duration) * (1 - COALESCE(discount, 0.1)), 2) AS discounted_revenue 
FROM rental; 

SELECT rental_id, rental_date 
FROM rental 
WHERE rental_date = CURRENT_DATE; 

SELECT NOW() AS current_datetime; 

SELECT  
rental_id,  
rental_date 
FROM rental 
WHERE rental_date = DATE('2005-05-25'); 

SELECT  
rental_id,  
EXTRACT(YEAR FROM rental_date) AS rental_year 
FROM rental;

SELECT  
rental_id,  
rental_date 
FROM rental 
WHERE MONTH(rental_date) = 12; 

SELECT  
rental_id,  
rental_date 
FROM rental 
WHERE rental_date >= DATE_SUB(CURRENT_DATE, INTERVAL 30 DAY); 

SELECT  
rental_id,  
rental_date,  
DATE_ADD(rental_date, INTERVAL 7 DAY) AS due_date 
FROM rental; 

SELECT  
rental_id,  
rental_date,  
DATEDIFF(CURRENT_DATE, rental_date) AS days_since_rental 
FROM rental; 

SELECT  
rental_id,  
rental_date, 
TIMESTAMPDIFF(HOUR, rental_date, NOW()) AS hours_since_rental 
FROM rental; 

SELECT  
rental_id,  
DATE_FORMAT(rental_date, '%M %d, %Y') AS formatted_date 
FROM rental; 

SELECT  
rental_id,  
TIME_FORMAT(rental_date, '%h:%i %p') AS formatted_time 
FROM rental; 

SELECT 
rental_id,  
rental_date, 
CONVERT_TZ(rental_date, 'UTC', 'America/New_York') AS local_rental_date 
FROM rental; 

SELECT rental_id, rental_date, 
       CASE 
           WHEN rental_date >= DATE_SUB(CURRENT_DATE, INTERVAL 90 DAY) THEN 'Recent' 
           ELSE 'Old' 
       END AS rental_status 
FROM rental;


SELECT EXTRACT(MONTH FROM rental_date) AS rental_month, 
       COUNT(*) AS total_rentals 
FROM rental 
WHERE EXTRACT(YEAR FROM rental_date) = YEAR(CURRENT_DATE) 
GROUP BY rental_month 
ORDER BY rental_month; 

SELECT * 
FROM rental 
WHERE rental_id = '5'; 

SELECT CAST(rental_id AS CHAR) AS rental_id_string 
FROM rental; 

SELECT  
CONCAT('Rental ID: ', CAST(rental_id AS CHAR)) AS rental_message 
FROM rental;

SELECT  
rental_id 
FROM rental 
WHERE rental_date = CAST('2005-05-25' AS DATE); 

SELECT * 
FROM rental 
WHERE CAST(rental_id AS CHAR) = '5'; 

SELECT  
COALESCE(CAST(rental_rate AS CHAR), 'N/A') AS rental_rate_string 
FROM rental; 

ALTER TABLE rental 
MODIFY rental_date DATE; 

SELECT CONCAT('$', FORMAT(rental_rate, 2)) AS formatted_rate 
FROM rental; 

SELECT rental_id, 
       DATEDIFF(CURRENT_DATE, CAST(rental_date AS DATE)) AS days_since_rental 
FROM rental; 