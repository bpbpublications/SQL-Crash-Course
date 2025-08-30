CREATE TABLE customer_feedback ( 
    feedback_id INTEGER PRIMARY KEY AUTOINCREMENT, 
    customer_id INTEGER NOT NULL, 
    film_id INTEGER NOT NULL, 
    feedback_text TEXT NOT NULL, 
    feedback_date DATETIME DEFAULT CURRENT_TIMESTAMP, 
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id), 
    FOREIGN KEY (film_id) REFERENCES film(film_id) 
);

INSERT INTO customer_feedback (customer_id, film_id, feedback_text) 
VALUES 
    (1, 10, 'Amazing film with a captivating storyline.'), 
    (2, 15, 'Good visuals but the plot was predictable.'), 
    (3, 20, 'Not my taste, but others might enjoy it.'), 
    (4, 5, 'One of the best performances I have seen.');

SELECT  
cf.feedback_id,  
c.first_name,  
c.last_name,  
f.title,  
cf.feedback_text,  
cf.feedback_date 
FROM customer_feedback cf 
JOIN customer c ON cf.customer_id = c.customer_id 
JOIN film f ON cf.film_id = f.film_id;

SELECT  
c.first_name,  
c.last_name, 
cf.feedback_text 
FROM 
customer_feedback cf 
JOIN customer c ON cf.customer_id = c.customer_id 
WHERE cf.film_id = 10;

SELECT  
f.title,  
COUNT(cf.feedback_id) AS feedback_count 
FROM customer_feedback cf 
JOIN film f ON cf.film_id = f.film_id 
GROUP BY f.film_id 
ORDER BY feedback_count DESC; 

SELECT  
c.first_name,  
c.last_name,  
COUNT(cf.feedback_id) AS total_feedback 
FROM customer_feedback cf 
JOIN customer c ON cf.customer_id = c.customer_id 
GROUP BY cf.customer_id 
ORDER BY total_feedback DESC;

CREATE INDEX idx_customer_id ON customer_feedback(customer_id); 
CREATE INDEX idx_film_id ON customer_feedback(film_id);

SELECT 
f.title,  
COUNT(cf.feedback_id) AS positive_feedback 
FROM customer_feedback cf 
JOIN film f ON cf.film_id = f.film_id 
WHERE cf.feedback_text LIKE '%amazing%' OR cf.feedback_text LIKE '%best%' 
GROUP BY cf.film_id 
ORDER BY positive_feedback DESC;

SELECT  
c.name AS category,  
COUNT(cf.feedback_id) AS total_feedback 
FROM customer_feedback cf 
JOIN film f ON cf.film_id = f.film_id 
JOIN film_category fc ON f.film_id = fc.film_id 
JOIN category c ON fc.category_id = c.category_id 
GROUP BY c.name 
ORDER BY total_feedback DESC; 