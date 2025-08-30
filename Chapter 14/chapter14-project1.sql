CREATE TABLE customers ( 
    customer_id INTEGER PRIMARY KEY AUTOINCREMENT, 
    first_name TEXT NOT NULL, 
    last_name TEXT NOT NULL, 
    email TEXT UNIQUE NOT NULL, 
    phone TEXT, 
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP 
);

CREATE TABLE interactions ( 
    interaction_id INTEGER PRIMARY KEY AUTOINCREMENT, 
    customer_id INTEGER NOT NULL, 
    interaction_date DATETIME NOT NULL, 
    interaction_type TEXT NOT NULL, 
    notes TEXT, 
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id) 
);

INSERT INTO customers (first_name, last_name, email, phone) 
VALUES 
    ('John', 'Doe', 'john.doe@example.com', '123-456-7890'), 
    ('Jane', 'Smith', 'jane.smith@example.com', '098-765-4321'), 
    ('Alice', 'Johnson', 'alice.johnson@example.com', NULL);

INSERT INTO interactions (customer_id, interaction_date, interaction_type, notes) 
VALUES 
    (1, '2024-01-15', 'Phone Call', 'Discussed service options'), 
    (2, '2024-01-20', 'Email', 'Sent follow-up details'), 
    (1, '2024-01-25', 'Meeting', 'Reviewed contract terms');

SELECT * FROM customers; 

SELECT first_name, last_name 
FROM customers 
WHERE email = 'john.doe@example.com'; 

SELECT interaction_date, interaction_type, notes 
FROM interactions 
WHERE customer_id = 1 
ORDER BY interaction_date;

UPDATE customers 
SET phone = '111-222-3333' 
WHERE email = 'alice.johnson@example.com'; 

DELETE FROM interactions 
WHERE interaction_id = 2;

SELECT  
c.first_name,  
c.last_name,  
COUNT(i.interaction_id) AS total_interactions 
FROM customers c 
JOIN interactions i  
ON c.customer_id = i.customer_id 
GROUP BY c.customer_id;

SELECT  
c.first_name,  
c.last_name,  
MAX(i.interaction_date) AS last_interaction 
FROM customers c 
JOIN interactions i  
ON c.customer_id = i.customer_id 
GROUP BY c.customer_id;

CREATE UNIQUE INDEX idx_email ON customers(email); 