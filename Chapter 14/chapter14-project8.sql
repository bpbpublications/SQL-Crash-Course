SELECT 
f.title, 
SUM(p.amount)AStotal_revenue 
FROM payment p 
JOIN rental r ON p.rental_id = r.rental_id 
JOIN inventory i ON r.inventory_id = i.inventory_id 
JOIN film f ON i.film_id = f.film_id 
GROUP BY f.title 
ORDER BY total_revenue DESC;

SELECT c.name AS category, SUM(p.amount) AS total_revenue 
FROM payment p 
JOIN rental r ON p.rental_id = r.rental_id 
JOIN inventory i ON r.inventory_id = i.inventory_id 
JOIN film_category fc ON i.film_id = fc.film_id 
JOIN category c ON fc.category_id = c.category_id 
GROUP BY c.name 
ORDER BY total_revenue DESC; 

SELECT  
c.first_name,  
c.last_name,  
COUNT(r.rental_id) AS total_rentals 
FROM rental r 
JOIN customer c ON r.customer_id = c.customer_id 
GROUP BY c.customer_id 
ORDER BY total_rentals DESC 
LIMIT 5;

SELECT  
c.first_name,  
c.last_name, cat.name AS category 
FROM rental r 
JOIN inventory i ON r.inventory_id = i.inventory_id 
JOIN film_category fc ON i.film_id = fc.film_id 
JOIN category cat ON fc.category_id = cat.category_id 
JOIN customer c ON r.customer_id = c.customer_id 
WHERE cat.name = 'Action' 
GROUP BY c.customer_id;

SELECT  
strftime('%Y-%m', r.rental_date) AS month,  
COUNT(r.rental_id) AS rental_count 
FROM rental r 
GROUP BY month 
ORDER BY month;

SELECT  
strftime('%Y-%m', r.rental_date) AS month,  
COUNT(r.rental_id) AS rental_count 
FROM rental r 
GROUP BY month 
ORDER BY rental_count DESC 
LIMIT 1;

SELECT  
f.title,  
COUNT(r.rental_id) AS rental_count 
FROM rental r 
JOIN inventory i ON r.inventory_id = i.inventory_id 
JOIN film f ON i.film_id = f.film_id 
GROUP BY f.film_id 
ORDER BY rental_count DESC 
LIMIT 10;

SELECT  
c.name AS category,  
COUNT(r.rental_id) AS rental_count 
FROM rental r 
JOIN inventory i ON r.inventory_id = i.inventory_id 
JOIN film_category fc ON i.film_id = fc.film_id 
JOIN category c ON fc.category_id = c.category_id 
GROUP BY c.name 
ORDER BY rental_count DESC;

SELECT  
c.name AS category,  
f.title, COUNT(r.rental_id) AS rental_count,  
SUM(p.amount) AS total_revenue 
FROM payment p 
JOIN rental r ON p.rental_id = r.rental_id 
JOIN inventory i ON r.inventory_id = i.inventory_id 
JOIN film_category fc ON i.film_id = fc.film_id 
JOIN category c ON fc.category_id = c.category_id 
JOIN film f ON i.film_id = f.film_id 
GROUP BY c.name, f.title 
ORDER BY total_revenue DESC;

SELECT  
c.first_name,  
c.last_name,  
f.title,  
r.rental_date,  
r.return_date,  
julianday(r.return_date) - julianday(r.rental_date) AS days_rented 
FROM rental r 
JOIN customer c ON r.customer_id = c.customer_id 
JOIN inventory i ON r.inventory_id = i.inventory_id 
JOIN film f ON i.film_id = f.film_id 
WHERE julianday(r.return_date) - julianday(r.rental_date) > 7 
ORDER BY days_rented DESC; 