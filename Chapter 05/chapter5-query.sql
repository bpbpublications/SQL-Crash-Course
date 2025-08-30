SELECT first_name AS "First Name", last_name AS "Last Name" 
FROM customer;

SELECT SUM(amount) AS "Total Amount" 
FROM payment; 

SELECT c.first_name as 'First Name', p.amount 'Amount' 
FROM customer c  
INNER JOIN payment p
ON c.customer_id = p.customer_id 

SELECT s1.first_name AS "Employee", s2.first_name as "Colleague", s1.store_id 
FROM staff AS s1 
JOIN staff AS s2 
ON s1.store_id = s2.store_id 
WHERE s1.staff_id <> s2.staff_id;

SELECT c.customer_id, p1.amount, COUNT(p1.amount)  
FROM customer AS c 
INNER JOIN payment AS p1 ON c.customer_id = p1.customer_id  
WHERE amount >  
      (SELECT AVG(amount)  
       FROM payment p2  
       WHERE p2.customer_id = p1.customer_id)  
GROUP BY c.customer_id;

SELECT DISTINCT rating 
FROM film; 

SELECT DISTINCT rating, special_features 
FROM film;

SELECT COUNT(DISTINCT rating)
FROM film;

SELECT SUM(DISTINCT amount) AS total_unique_amount 
FROM payment;

SELECT DISTINCT store_id 
FROM staff 
JOIN store ON staff.store_id = store.store_id; 

SELECT customer_id, COUNT(rental_id) AS rental_count 
FROM rental 
GROUP BY customer_id;

SELECT rental_id, SUM(amount) as total_sales 
FROM payment 
GROUP BY rental_id; 

SELECT customer_id, AVG(amount) as avg_sales 
FROM payment 
GROUP BY rental_id;

SELECT r.inventory_id, p.staff_id, SUM(amount) as total_sales  
FROM payment AS p INNER JOIN rental AS r 
ON p.rental_id = r.rental_id 
GROUP BY r.inventory_id, p.staff_id;

SELECT customer_id, COUNT(rental_id) AS rental_count 
FROM rental 
GROUP BY customer_id 
HAVING COUNT(rental_id) > 5;

SELECT customer_id, inventory_id, COUNT(rental_id) AS rental_count 
FROM rental 
GROUP BY customer_id, inventory_id

SELECT COUNT(*) AS total_rental 
FROM rental; 

SELECT COUNT(rental_id) AS total_rentals 
FROM rental; 

SELECT SUM(amount) AS total_sales 
FROM payment; 

SELECT AVG(amount) AS average_payment 
FROM payment; 

SELECT MIN(amount) AS smallest_payment, MAX(amount) AS largest_payment 
FROM payment; 

SELECT COUNT(DISTINCT customer_id) AS unique_customers 
FROM payment; 

SELECT rental_id, SUM(amount) AS total_sales 
FROM payment 
GROUP BY rental_id; 

SELECT customer_id, amount 
FROM payment  
WHERE amount > (SELECT AVG(amount) FROM payment); 
SELECT rental_id, amount,  
       (SELECT SUM(amount)  
        FROM payment p2  
        WHERE p2.customer_id = p1.customer_id) AS total_sales 
FROM payment p1; 

SELECT r.rental_id, sales_data.total_sales 
FROM rental r 
JOIN (SELECT rental_id, SUM(amount) AS total_sales  
      FROM payment  
      GROUP BY rental_id) AS sales_data  
ON r.rental_id = sales_data.rental_id 
ORDER BY sales_data.total_sales DESC; 

SELECT rental_id, SUM(amount) AS total_revenue  
FROM payment  
GROUP BY rental_id  
HAVING SUM(amount) > (SELECT AVG(total_revenue)  
FROM (SELECT rental_id, SUM(amount) AS total_revenue 
FROM payment  
GROUP BY rental_id) AS category_totals); 


SELECT e1.employee_id, e1.salary 
FROM employees e1 
WHERE e1.salary > (SELECT AVG(e2.salary) 
                   FROM employees e2 
                   WHERE e2.department_id = e1.department_id); 


SELECT customer_id, first_name, last_name 
FROM customer c 
WHERE NOT EXISTS (SELECT 1 
                  FROM rental r 
                  WHERE r.customer_id = c.customer_id); 

SELECT first_name, last_name, active 
FROM customer 
WHERE active = 0; 

SELECT first_name, last_name, active 
FROM customer 
WHERE active IS NULL; 

SELECT first_name, last_name, active 
FROM customer 
WHERE active IS NOT NULL; 

SELECT first_name, last_name, active 
FROM customer 
WHERE active = NULL;

SELECT first_name, COALESCE(active, 0) AS active 
FROM customer; 

SELECT first_name, COALESCE(active, create_date, 0) AS compensation 
FROM customer;

SELECT SUM(amount) AS total_amount 
FROM payment;

SELECT COALESCE(SUM(amount), 0) AS total_amount 
FROM payment;

SELECT COUNT(*) AS total_payments, COUNT(amount) AS payment_with_amount 
FROM payment;

SELECT staff.first_name, store.store_id 
FROM staff 
LEFT JOIN store ON staff.store_id = store.store_id;

SELECT rating, COUNT(film_id) as 'total_number_of_films' 
FROM film 
GROUP BY rating; 

SELECT special_features, COUNT(film_id) as 'total_number_of_films' 
FROM film 
GROUP BY special_features;  

SELECT c.name, COUNT(f.film_id) as 'total_number_of_films' 
FROM film f 
INNER JOIN film_category fc 
ON f.film_id = fc.film_id 
INNER JOIN category c 
ON fc.category_id = c.category_id 
GROUP BY c.category_id 

SELECT f.film_id, f.title, COUNT(r.rental_id) as 'count_of_rentals'    
FROM rental r  
INNER JOIN inventory i  
ON r.inventory_id = i.inventory_id  
INNER JOIN film f  
ON i.film_id = f.film_id  
GROUP BY f.title  
ORDER BY COUNT(r.rental_id) DESC; 


SELECT f.title, SUM(p.amount) as 'sum_of_payment'  
FROM film as f  
INNER JOIN inventory i  
ON f.film_id = i.film_id  
INNER JOIN rental r  
ON i.inventory_id = r.inventory_id  
INNER JOIN payment p  
ON r.rental_id = p.rental_id 
GROUP BY f.title 
ORDER BY SUM(p.amount) DESC; 

SELECT c.customer_id, p.amount   
FROM payment p  
INNER JOIN customer c  
ON p.customer_id = c.customer_id  
WHERE p.amount > (SELECT AVG(amount) FROM payment)  
GROUP BY c.customer_id  
ORDER BY p.amount DESC; 

insert into customer ( 
customer_id,  
store_id,  
first_name,  
last_name,  
email, 
address_id,  
active,  
create_date,  
last_update,  
full_name,  
phone_number) 
VALUES ( 
600, 
2, 
'SOPHIA', 
'JONES', 
'SOPHIA.JONES@sakilacustomer.org',  
605,  
1,  
02-14-2006,  
02-14-2006,  
'SOPHIA JONES',  
'5558135678'); 

SELECT customer_id, first_name, last_name  
FROM customer c  
WHERE NOT EXISTS (SELECT 1 
FROM rental r  
WHERE r.customer_id = c.customer_id); 

