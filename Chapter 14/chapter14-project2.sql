CREATE TABLE products ( 
    product_id INTEGER PRIMARY KEY AUTOINCREMENT, 
    product_name TEXT NOT NULL, 
    category TEXT NOT NULL, 
    price REAL NOT NULL 
);

CREATE TABLE sales ( 
    sale_id INTEGER PRIMARY KEY AUTOINCREMENT, 
    product_id INTEGER NOT NULL, 
    quantity INTEGER NOT NULL, 
    sale_date DATETIME NOT NULL, 
    customer_name TEXT NOT NULL, 
    FOREIGN KEY (product_id) REFERENCES products(product_id) 
);

INSERT INTO products (product_name, category, price) 
VALUES 
    ('Laptop', 'Electronics', 1200.00), 
    ('Headphones', 'Electronics', 150.00), 
    ('Coffee Maker', 'Appliances', 80.00), 
    ('Desk Chair', 'Furniture', 200.00);

INSERT INTO sales (product_id, quantity, sale_date, customer_name) 
VALUES 
    (1, 2, '2024-01-10', 'John Doe'), 
    (2, 1, '2024-01-11', 'Jane Smith'), 
    (3, 3, '2024-01-12', 'Alice Johnson'), 
    (4, 1, '2024-01-13', 'Tom Brown'); 

SELECT * FROM sales; 

SELECT
s.sale_date,
s.customer_name,
p.product_name,
s.quantity,
p.price
FROM
sales s
JOIN products p
ON s.product_id = p.product_id;

SELECT  
p.product_name,  
SUM(s.quantity * p.price) AS total_revenue 
FROM sales s 
JOIN products p  
ON s.product_id = p.product_id 
GROUP BY p.product_id 
ORDER BY total_revenue DESC;

SELECT  
p.category,  
SUM(s.quantity) AS total_quantity 
FROM sales s 
JOIN products p ON s.product_id = p.product_id 
GROUP BY p.category 
ORDER BY total_quantity DESC;  

SELECT  
strftime('%Y-%m', s.sale_date) AS month,  
SUM(s.quantity * p.price) AS monthly_revenue 
FROM sales s 
JOIN products p ON s.product_id = p.product_id 
GROUP BY month 
ORDER BY month;

SELECT  
strftime('%Y-%m', sale_date) AS month,  
COUNT(*) AS total_sales 
FROM sales 
GROUP BY month 
ORDER BY total_sales DESC 
LIMIT 1; 

CREATE INDEX idx_product_id ON sales(product_id); 
CREATE INDEX idx_sale_date ON sales(sale_date); 