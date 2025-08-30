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

SELECT  
region,  
SUM(quantity * price) AS total_revenue 
FROM sales 
GROUP BY region; 

SELECT  
strftime('%Y-%m', sale_date) AS month, SUM(quantity * price) AS monthly_revenue 
FROM sales 
GROUP BY month 
ORDER BY month; 

-- PYTHON Code
import sqlite3 
import pandas as pd 
 
# Connect to the database 
conn = sqlite3.connect('automated_reports.db') 
 
# Query total revenue by region 
query1 = "SELECT region, SUM(quantity * price) AS total_revenue FROM sales GROUP BY region" 
regional_revenue = pd.read_sql_query(query1, conn) 
 
# Query monthly revenue 
query2 = "SELECT strftime('%Y-%m', sale_date) AS month, SUM(quantity * price) AS monthly_revenue FROM sales GROUP BY month ORDER BY month" 
 

monthly_revenue = pd.read_sql_query(query2, conn)

# Write data to Excel 

with pd.ExcelWriter('sales_report.xlsx', engine='openpyxl') as writer: 
  regional_revenue.to_excel(writer,sheet_name='RegionalRevenue') 
  monthly_revenue.to_excel(writer,sheet_name='Monthly Revenue') 
  print("Reports generated and saved as 'sales_report.xlsx'.")  