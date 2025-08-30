CREATE TABLE film_ratings ( 
    rating_id INTEGER PRIMARY KEY AUTOINCREMENT, 
    customer_id INTEGER NOT NULL, 
    film_id INTEGER NOT NULL, 
    rating INTEGER NOT NULL CHECK (rating BETWEEN 1 AND 5), 
    rating_date DATETIME DEFAULT CURRENT_TIMESTAMP, 
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id), 
    FOREIGN KEY (film_id) REFERENCES film(film_id) 
); 

INSERT INTO film_ratings (customer_id, film_id, rating) 
VALUES 
    (1, 10, 5), 
    (2, 15, 4), 
    (3, 8, 3), 
    (4, 20, 5), 
    (5, 5, 2); 

SELECT  
fr.rating_id,  
c.first_name,  
c.last_name,  
f.title,  
fr.rating,  
fr.rating_date 
FROM film_ratings fr 
JOIN customer c ON fr.customer_id = c.customer_id 
JOIN film f ON fr.film_id = f.film_id; 

SELECT  
f.title, AVG(fr.rating) AS avg_rating 
FROM film_ratings fr 
JOIN film f ON fr.film_id = f.film_id 
GROUP BY f.film_id 
ORDER BY avg_rating DESC;

SELECT 
f.title 
FROM 
film_ratings fr 
JOIN film f ON fr.film_id = f.film_id 
WHERE fr.rating = 5;

SELECT  
f.title,  
COUNT(fr.rating) AS total_ratings 
FROM film_ratings fr 
JOIN film f ON fr.film_id = f.film_id 
GROUP BY f.film_id 
ORDER BY total_ratings DESC;

SELECT  
fr.rating,  
COUNT(fr.rating) AS frequency 
FROM film_ratings fr 
GROUP BY fr.rating 
ORDER BY frequency DESC; 

CREATE INDEX idx_customer_id ON film_ratings(customer_id); 
CREATE INDEX idx_film_id ON film_ratings(film_id); 

SELECT  
c.name AS category,  
AVG(fr.rating) AS avg_rating 
FROM film_ratings fr 
JOIN film f ON fr.film_id = f.film_id 
JOIN film_category fc ON f.film_id = fc.film_id 
JOIN category c ON fc.category_id = c.category_id 
GROUP BY c.name 
ORDER BY avg_rating DESC;

SELECT 
c.name AS category,  
f.title,  
AVG(fr.rating) AS avg_rating 
FROM film_ratings fr 
JOIN film f ON fr.film_id = f.film_id 
JOIN film_category fc ON f.film_id = fc.film_id 
JOIN category c ON fc.category_id = c.category_id 
GROUP BY c.name, f.title 
HAVING AVG(fr.rating) > 4 
ORDER BY avg_rating DESC; 