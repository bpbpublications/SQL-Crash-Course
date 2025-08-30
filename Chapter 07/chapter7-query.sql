SELECT first_name, last_name
FROM actor
UNION
SELECT first_name, last_name
FROM customer;

SELECT first_name, last_name
FROM actor
UNION ALL
SELECT first_name, last_name
FROM customer;

SELECT first_name, last_name
FROM actor
INTERSECT
SELECT first_name, last_name
FROM customer;

SELECT first_name, last_name
FROM actor
EXCEPT
SELECT first_name, last_name
FROM customer;

SELECT title, release_year
FROM film
UNION
SELECT name AS title, NULL AS release_year
FROM category;

SELECT rental_id, rental_date
FROM rental
UNION ALL
SELECT payment_id AS rental_id, payment_date AS rental_date
FROM payment;

SELECT title, rental_rate
FROM film
UNION ALL
SELECT name AS title, NULL AS rental_rate
FROM category
ORDER BY title;

SELECT store_id, total_amount
FROM payment
WHERE total_amount > 50
UNION
SELECT store_id, NULL AS total_amount
FROM rental
WHERE rental_date > DATE('2006-01-01');

SELECT rental_id, customer_id
FROM rental
INTERSECT
SELECT rental_id, customer_id
FROM payment;

SELECT rental_id, customer_id, rental_date
FROM rental_store1
INTERSECT
SELECT rental_id, customer_id, rental_date
FROM rental_store2;


SELECT customer_id, first_name || ' ' || last_name AS full_name
FROM customer
JOIN rental ON customer.customer_id = rental.customer_id
INTERSECT
SELECT customer_id, first_name || ' ' || last_name AS full_name
FROM customer
JOIN payment ON customer.customer_id = payment.customer_id;

SELECT film_id, title
FROM inventory
WHERE available = 'Y'
INTERSECT
SELECT film_id, title
FROM rental
WHERE rental_date > DATE('2005-01-01');

SELECT customer_id, film_id
FROM rental
JOIN film ON rental.film_id = film.film_id
WHERE special_features IS NU
INTERSECT
SELECT customer_id, film_id
FROM rental
JOIN film ON rental.film_id = film.film_id
WHERE special_features IS NOT NULL;

SELECT film_id, title
FROM film
EXCEPT
SELECT film_id, title
FROM inventory;

SELECT film_id, title
FROM film
EXCEPT
SELECT film_id, title
FROM rental;

SELECT customer_id, first_name || ' ' || last_name AS full_name
FROM customer
EXCEPT
SELECT customer_id, first_name || ' ' || last_name AS full_name
FROM payment;

SELECT customer_id, first_name || ' ' || last_name AS full_name
FROM rental
JOIN customer ON rental.customer_id = customer.customer_id
WHERE rental_date > DATE('2006-01-01')
EXCEPT
SELECT customer_id, first_name || ' ' || last_name AS full_name
FROM loyalty_program;

SELECT film_id, title
FROM old_inventory
EXCEPT
SELECT film_id, title
FROM new_inventory;

SELECT first_name, last_name
FROM actor
UNION
SELECT first_name, last_name
FROM staff
INTERSECT
SELECT first_name, last_name
FROM film_actor EXCEPT
SELECT first_name, last_name
FROM inactive_staff;

(SELECT first_name, last_name
FROM actor
EXCEPT
SELECT first_name, last_name
FROM inactive_actors) -- Assuming inactive_actors lists actors no longer active
UNION
SELECT first_name, last_name
FROM staff
WHERE active = 'Y';


SELECT first_name, last_name
FROM actor
UNION
SELECT first_name, last_name
FROM film_directors
INTERSECT
SELECT first_name, last_name
FROM active_cast;

(SELECT first_name, last_name
FROM actor
UNION
SELECT first_name, last_name
FROM film_directors)
INTERSECT
SELECT first_name, last_name
FROM active_cast;

(SELECT first_name || ' ' || last_name AS name
FROM staff_projects
INTERSECT
SELECT first_name || ' ' || last_name AS name
FROM management_team)
EXCEPT
SELECT first_name || ' ' || last_name AS name
FROM leave_list;

(SELECT first_name, last_name FROM actor
UNION
SELECT first_name, last_name FROM staff)
ORDER BY last_name;


WITH actor_list AS (
SELECT first_name, last_name
FROM actor
),
staff_list AS (
SELECT first_name, last_name
FROM staff
)
SELECT * FROM actor_list
UNION
SELECT * FROM staff_list
ORDER BY last_name;

SELECT first_name, last_name FROM actor ORDER BY last_name
UNION
SELECT first_name, last_name FROM staff ORDER BY last_name;


SELECT first_name, last_name, 'Actor' AS source
FROM actor
UNION ALL
SELECT first_name, last_name, 'Staff' AS source
FROM staff
ORDER BY source, last_name;


SELECT first_name, last_name
FROM actor
WHERE actor_id IN (
    SELECT actor_id
    FROM film_actor
    JOIN film_category ON film_actor.film_id = film_category.film_id
    JOIN category ON film_category.category_id = category.category_id
    WHERE category.name = 'Action'
)
UNION
SELECT first_name, last_name
FROM staff
WHERE staff_id IN (
    SELECT staff_id
    FROM project_staff
    JOIN projects ON project_staff.project_id = projects.project_id
    WHERE projects.budget > 100000
);


SELECT first_name FROM actor
UNION
SELECT first_name FROM customer;

SELECT title AS name FROM film
UNION
SELECT name FROM category;

SELECT city FROM address
UNION
SELECT city FROM store;

SELECT first_name FROM actor
UNION ALL
SELECT first_name FROM customer;

SELECT description FROM film
UNION ALL
SELECT special_features FROM film;


SELECT first_name FROM actor
INTERSECT
SELECT first_name FROM customer;

SELECT first_name FROM actor
EXCEPT
SELECT first_name FROM customer;