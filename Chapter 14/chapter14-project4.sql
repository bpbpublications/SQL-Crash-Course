CREATE TABLE sales ( 
    sale_id INTEGER PRIMARY KEY AUTOINCREMENT, 
    region TEXT NOT NULL, 
    product TEXT NOT NULL, 
    quantity INTEGER NOT NULL, 
    price REAL NOT NULL, 
    sale_date DATETIME NOT NULL 
);

INSERT INTO sales (region, product, quantity, price, sale_date) 
VALUES 
    ('North', 'Laptop', 10, 1200.00, '2024-01-10'), 
    ('South', 'Tablet', 15, 500.00, '2024-01-11'), 
    ('East', 'Smartphone', 20, 800.00, '2024-01-12'), 
    ('West', 'Headphones', 25, 150.00, '2024-01-13'),
    ('North', 'Tablet', 12, 300.00, '2024-02-14'), 
    ('South', 'Laptop', 8, 2000.00, '2024-02-15'),
    ('North', 'Laptop', 10, 1500.00, '2024-02-10'), 
    ('South', 'Tablet', 15, 400.00, '2024-03-11'), 
    ('East', 'Smartphone', 20, 1300.00, '2024-03-12'), 
    ('West', 'Headphones', 25, 750.00, '2024-03-13');

SELECT region, SUM(quantity * price) AS total_revenue 
FROM sales 
GROUP BY region; 

SELECT product, SUM(quantity) AS total_sales 
FROM sales 
GROUP BY product;

SELECT strftime('%Y-%m', sale_date) AS month, SUM(quantity * price) AS monthly_revenue 
FROM sales 
GROUP BY month 
ORDER BY month;

.headers on 
.mode csv 
.output regional_revenue.csv
SELECT region, SUM(quantity * price) AS total_revenue 
FROM sales 
GROUP BY region;
.output

.headers on 
.mode csv 
.output monthly_revenue.csv
SELECT strftime('%Y-%m', sale_date) AS month, SUM(quantity * price) AS monthly_revenue 
FROM sales 
GROUP BY month 
ORDER BY month; 
.output

-- Python Code
import pandas as pd 
import matplotlib.pyplot as plt 
 
# Load data 
regional_revenue = pd.read_csv('regional_revenue.csv') 
monthly_revenue = pd.read_csv('monthly_revenue.csv')

plt.bar(regional_revenue['region'],regional_revenue['total_revenue'], color='blue') 
plt.title('Total Revenue by Region') 
plt.xlabel('Region') 
plt.ylabel('Revenue') 
plt.show() 

plt.plot(monthly_revenue['month'],monthly_revenue['monthly_revenue'], marker='o') 
plt.title('Monthly Revenue Trends') 
plt.xlabel('Month') 
plt.ylabel('Revenue') 
plt.xticks(rotation=45) 
plt.show() 