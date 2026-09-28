
USE ecommerce_project;

CREATE TABLE customers (customer_id VARCHAR(20) PRIMARY KEY, customer_unique_id VARCHAR(20), customer_zip_code_prefix INT, customer_city VARCHAR(100), customer_state VARCHAR(5));
CREATE TABLE products (product_id VARCHAR(20) PRIMARY KEY, product_category_name VARCHAR(50), product_name_length INT, product_description_length INT NULL, product_photos_qty INT NULL, product_weight_g INT NULL, product_length_cm INT, product_height_cm INT, product_width_cm INT);
CREATE TABLE sellers (seller_id VARCHAR(20) PRIMARY KEY, seller_zip_code_prefix INT, seller_city VARCHAR(100), seller_state VARCHAR(5));
CREATE TABLE orders (order_id VARCHAR(20) PRIMARY KEY, customer_id VARCHAR(20), order_status VARCHAR(30), order_purchase_timestamp DATETIME, order_approved_at DATETIME NULL, order_delivered_customer_date DATETIME NULL, order_estimated_delivery_date DATETIME, FOREIGN KEY(customer_id) REFERENCES customers(customer_id));
CREATE TABLE order_items (order_id VARCHAR(20), order_item_id INT, product_id VARCHAR(20), seller_id VARCHAR(20), price DECIMAL(12,2), freight_value DECIMAL(12,2), PRIMARY KEY(order_id,order_item_id), FOREIGN KEY(order_id) REFERENCES orders(order_id), FOREIGN KEY(product_id) REFERENCES products(product_id), FOREIGN KEY(seller_id) REFERENCES sellers(seller_id));
CREATE TABLE order_payments (order_id VARCHAR(20), payment_sequential INT, payment_type VARCHAR(30), payment_installments INT, payment_value DECIMAL(12,2), PRIMARY KEY(order_id,payment_sequential), FOREIGN KEY(order_id) REFERENCES orders(order_id));
CREATE TABLE order_reviews (review_id VARCHAR(30) PRIMARY KEY, order_id VARCHAR(20), review_score INT, review_comment_title VARCHAR(255) NULL, review_comment_message VARCHAR(500) NULL, review_creation_date DATETIME, FOREIGN KEY(order_id) REFERENCES orders(order_id));
CREATE TABLE product_category_translation (product_category_name VARCHAR(50) PRIMARY KEY, product_category_name_english VARCHAR(50));
-- Import CSVs with LOCAL INFILE. Adjust path to your extracted folder.
-- SET GLOBAL local_infile=1;
-- LOAD DATA LOCAL INFILE 'C:/PATH/customers.csv' INTO TABLE customers FIELDS TERMINATED BY ',' ENCLOSED BY '"' IGNORE 1 ROWS;
-- LOAD DATA LOCAL INFILE 'C:/PATH/products.csv' INTO TABLE products FIELDS TERMINATED BY ',' ENCLOSED BY '"' IGNORE 1 ROWS;
-- LOAD DATA LOCAL INFILE 'C:/PATH/sellers.csv' INTO TABLE sellers FIELDS TERMINATED BY ',' ENCLOSED BY '"' IGNORE 1 ROWS;
-- LOAD DATA LOCAL INFILE 'C:/PATH/orders.csv' INTO TABLE orders FIELDS TERMINATED BY ',' ENCLOSED BY '"' IGNORE 1 ROWS;
-- LOAD DATA LOCAL INFILE 'C:/PATH/order_items.csv' INTO TABLE order_items FIELDS TERMINATED BY ',' ENCLOSED BY '"' IGNORE 1 ROWS;
-- LOAD DATA LOCAL INFILE 'C:/PATH/order_payments.csv' INTO TABLE order_payments FIELDS TERMINATED BY ',' ENCLOSED BY '"' IGNORE 1 ROWS;
-- LOAD DATA LOCAL INFILE 'C:/PATH/order_reviews.csv' INTO TABLE order_reviews FIELDS TERMINATED BY ',' ENCLOSED BY '"' IGNORE 1 ROWS;
-- LOAD DATA LOCAL INFILE 'C:/PATH/product_category_translation.csv' INTO TABLE product_category_translation FIELDS TERMINATED BY ',' ENCLOSED BY '"' IGNORE 1 ROWS;


USE ecommerce_project;

LOAD DATA LOCAL INFILE 'C:/Users/anitha/Downloads/ecommerce_sql_project_dataset/customers.csv'
INTO TABLE customers
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
IGNORE 1 ROWS;


USE ecommerce_project;

SELECT COUNT(*) AS total_customers
FROM customers;

SELECT *
FROM customers
LIMIT 10;


SELECT COUNT(*) AS total_products
FROM products;

SELECT *
FROM products
LIMIT 10;

			
USE ecommerce_project;

DELETE FROM product_category_translation;

SELECT DATABASE();

SELECT COUNT(*) AS total_categories
FROM product_category_translation;


USE ecommerce_project;

SELECT DATABASE();

SELECT COUNT(*) AS total_categories
FROM product_category_translation;

USE ecommerce_project;

SELECT COUNT(*) AS total_categories
FROM product_category_translation;

SELECT *
FROM product_category_translation;

USE ecommerce_project;

DELETE FROM product_category_translation;



USE ecommerce_project;

DELETE FROM product_category_translation
WHERE product_category_name IS NOT NULL;

USE ecommerce_project;

SET SQL_SAFE_UPDATES = 0;

DELETE FROM product_category_translation;

SET SQL_SAFE_UPDATES = 1;

SELECT COUNT(*) AS total_categories
FROM product_category_translation;


USE ecommerce_project;



SELECT *
FROM product_category_translation;

SELECT COUNT(*) AS total_categories
FROM product_category_translation;




SHOW TABLES;

SELECT
    TABLE_NAME,
    TABLE_ROWS
FROM information_schema.TABLES
WHERE TABLE_SCHEMA = 'ecommerce_project';




SELECT *
FROM orders
LIMIT 10;


SELECT
    order_status,
    COUNT(*) AS total_orders
FROM orders
GROUP BY order_status
ORDER BY total_orders DESC;
            
            
SHOW DATABASES;

USE ecommerce_project;
SHOW TABLES;



SELECT COUNT(*) AS total_customers
FROM customers;

USE ecommerce_project;

SELECT COUNT(*) AS total_customers
FROM customers;

SELECT COUNT(*) AS total_orders
FROM orders;

SELECT COUNT(*) AS total_order_items
FROM order_items;

SELECT COUNT(*) AS total_order_payments
FROM order_payments;

SELECT COUNT(*) AS total_order_reviews
FROM order_reviews;

SELECT COUNT(*) AS total_products
FROM products;

SELECT COUNT(*) AS total_sellers
FROM sellers;

SELECT COUNT(*) AS total_category_translations
FROM product_category_translation;


USE ecommerce_project;

DESCRIBE customers;
DESCRIBE orders;
DESCRIBE order_items;
DESCRIBE order_payments;
DESCRIBE order_reviews;
DESCRIBE products;
DESCRIBE sellers;DESCRIBE product_category_translation;



use ecommerce_project;
SELECT * FROM order_items;
SELECT * FROM order_payments;
SELECT * FROM orders;
SELECT * FROM sellers;
SELECT * FROM PRODUCTS;
SELECT * FROM PRODUCT_CATEGORY_TRANSLATION;



------------------------------------------------------------------------------


USE ecommerce_project;

SELECT COUNT(*) AS total_order FROM ORDERS;



SELECT 
year(order_purchase_timestamp) AS YEAR,
month(order_purchase_timestamp) AS  MONTH ,
count(order_purchase_timestamp) AS TOTAL_ORDERS
FROM orders
group by 
year(order_purchase_timestamp),
month(order_purchase_timestamp)
ORDER BY
YEAR,
MONTH;



-- Q1
-- Calculate the total number of orders placed in each month of each year. Display the year, month, and total number of orders, sorted chronologically.


SELECT 
year(order_purchase_timestamp) AS YEAR,
MONTH(order_purchase_timestamp) AS MONTH,
count(order_purchase_timestamp) AS TOTAL_ORDERS
FROM orders
GROUP BY 
YEAR(order_purchase_timestamp),
MONTH(order_purchase_timestamp);


-- Q2

-- Calculate the total number of orders for each year. Display the year and total orders, sorted by year.


SELECT YEAR(order_purchase_timestamp),
count(order_purchase_timestamp)
FROM orders
GROUP BY YEAR(order_purchase_timestamp);


-- Q3

-- Find the total number of unique customers in the customer database.


SELECT COUNT(distinct customer_id) AS UNIQUE_CUSTOMER
FROM customers;

-- Q4

-- Find the number of customers in each state. Display the states from the highest number of customers to the lowest.


SELECT  customer_state, COUNT(customer_id) AS Total_customer
FROM CUSTOMERS
GROUP BY customer_state
ORDER BY Total_customer DESC;


-- Q5
-- Identify the top 10 cities with the highest number of customers.


SELECT customer_city, COUNT(customer_id) AS TOTAL_CUSTOMER
FROM customers
GROUP BY customer_city
order by TOTAL_CUSTOMER DESC
limit 10;


-- Q6
-- Calculate the number of orders for each order status.

SELECT order_status,
COUNT(order_status) AS TOTAL_ORDERS
FROM orders
GROUP BY order_status;


-- Q7
-- Calculate the average payment value across all payment records.

SELECT AVG(payment_value) AS average_payment
 FROM order_payments;


-- Q8
-- Identify the most frequently used payment type based on the number of payment records.

SELECT payment_type, 
COUNT(payment_type) AS pay_type 
FROM order_payments
GROUP BY payment_type
ORDER BY pay_type DESC
LIMIT 1;



-- Q9
-- Find the distribution of payment installments by calculating how many payment records exist for each installment count.  Sort the results by installment count in descending order.


SELECT payment_installments,
COUNT(payment_installments) AS total_payment
FROM order_payments
GROUP BY payment_installments
ORDER BY payment_installments DESC;


-- Q10
-- Calculate the number of products in each product category and rank the categories from the highest number of products to the lowest.

SELECT 
    product_category_name,
    COUNT(product_id) AS TOTAL_PRODUCTS
FROM products
GROUP BY product_category_name
ORDER BY TOTAL_PRODUCTS DESC;


-- Q11
-- The Customer Operations team wants to connect customer information with their orders. Return each customer ID, customer city, customer state, and their associated order ID.

SELECT c.customer_ID, c.customer_city, c.customer_state, o.order_ID
FROM customers AS c
INNER JOIN orders AS o 
ON c.customer_ID = o.customer_ID;



-- Q12
-- The Product team wants to know which product categories have the highest number of items sold. Calculate the total number of order items sold for each product category and rank the categories from highest to lowest.


SELECT p.product_category_name AS product_category,
COUNT(o.order_item_id) AS product_count
FROM products AS p
INNER JOIN  order_items AS o
ON p.product_id = o.product_id
GROUP BY product_category
ORDER BY product_count DESC;


-- Q13
-- The Seller Management team wants to compare seller activity. Calculate the total number of order items associated with each seller and rank sellers from highest to lowest.

SELECT s.seller_id AS SELLER_INFO,
COUNT(o.order_item_id) AS total_order 
FROM sellers AS s 
INNER JOIN order_items AS o
ON s.seller_id = o.seller_id
GROUP BY SELLER_INFO
ORDER BY total_order DESC;



-- Q14
-- The Customer Experience team wants to understand the distribution of review scores. For each review score, calculate the total number of reviews received.

SELECT review_score AS review,
COUNT(review_score) AS TOTAL_review 
FROM order_reviews 
GROUP BY review;



-- Q15
-- Calculate the average customer review score across all reviews.

SELECT AVG(review_score) AS average_review_score
FROM order_reviews;



## Q1 — Customers by State
-- Find the number of customers in each state. Display the states from the highest number of customers to the lowest.

SELECT customer_state, COUNT(customer_id) AS total_customers 
FROM customers
GROUP BY customer_state
ORDER BY total_customers DESC;




## Q2 — Top 10 Customer Cities
 -- Identify the top 10 cities with the highest number of customers.


SELECT customer_city, COUNT(customer_id) AS total_customer
FROM customers
GROUP BY customer_city
ORDER BY total_customer DESC
LIMIT 10;




## Q3 — Orders by Status
-- Calculate the number of orders for each order status and display the results from highest to lowest.

SELECT order_status, COUNT(order_id) AS total_orders
FROM orders
GROUP BY order_status
ORDER BY total_orders DESC;



## Q4 — Orders by Year
-- Calculate the total number of orders placed in each year. Display the year and total number of orders, sorted by year.

SELECT 
YEAR(order_purchase_timestamp) AS YEAR_ORDER, 
COUNT(order_id) AS total_orders
FROM orders
GROUP BY YEAR_ORDER
ORDER BY YEAR_ORDER;




## Q5 — Monthly Orders by Year
-- Calculate the total number of orders placed in each month of each year. Display the year, month, and total orders in chronological order.

SELECT 
YEAR(order_purchase_timestamp) AS YEAR,
MONTH(order_purchase_timestamp) AS MONTH,
COUNT(order_id) AS total_orders
FROM orders
GROUP BY 
YEAR(order_purchase_timestamp),
MONTH(order_purchase_timestamp)
ORDER BY YEAR, MONTH;




## Q6 — Average Payment Value
-- Calculate the average payment value across all payment records.

SELECT AVG(payment_value) AS average_payment
FROM order_payments;




## Q7 — Most Frequently Used Payment Type
-- Identify the most frequently used payment type based on the number of payment records.

SELECT payment_type, 
COUNT(payment_type) AS Total_payment
FROM order_payments
GROUP BY payment_type
ORDER BY Total_payment DESC
LIMIT 1;




## Q8 — Most Common Payment Installment Count
-- Identify the payment installment count that occurs most frequently. Display the installment count and the number of payment records.

SELECT payment_installments,
COUNT(payment_installments) AS total_payments
FROM order_payments
GROUP BY payment_installments
ORDER BY total_payments DESC
LIMIT 1;




## Q9 — Products Sold by Category
-- Calculate the total number of order items sold for each product category and rank the categories from highest to lowest.

SELECT p.product_category_name, 
COUNT(o.order_item_id) AS product_sold
FROM products AS p
INNER JOIN order_items AS o
ON p.product_id = o.product_id 
GROUP BY product_category_name
ORDER BY product_sold DESC;




## Q10 — Orders by Seller
-- Calculate the total number of distinct orders handled by each seller and rank sellers from highest to lowest.

SELECT  
s.seller_id, 
COUNT(DISTINCT o.order_id) AS total_orders
FROM order_items AS o
INNER JOIN sellers AS s
ON o.seller_id = s.seller_id
GROUP BY seller_id
ORDER BY total_orders DESC;




## Q11 — Customer Order Volume
-- Calculate the total number of orders placed by each customer. Display the customer ID and their total number of orders, with the highest-order customers first.

SELECT c.customer_id,
COUNT(o.order_id) AS total_orders
FROM customers AS c
INNER JOIN orders AS o
ON c.customer_id = o.customer_id
GROUP BY c.customer_id
ORDER BY total_orders DESC;




## Q12 — Average Review Score
-- Calculate the average customer review score across all reviews.

SELECT AVG(review_score) AS REVIEW
FROM order_reviews;





## Q13 — Average Review Score by Customer
-- For each customer, calculate their average review score and rank customers from the highest average review score to the lowest.

SELECT 
    o.customer_id,
    AVG(r.review_score) AS average_review
FROM orders AS o
INNER JOIN order_reviews AS r
    ON o.order_id = r.order_id
GROUP BY o.customer_id
ORDER BY average_review DESC;







## Q14 — Average Review Score by Seller
-- For each seller, calculate the average review score associated with their sold products/orders and rank sellers from highest to lowest average review score.

SELECT o.seller_id, AVG(r.review_score) AS average_review 
FROM order_reviews AS r
INNER JOIN order_items AS o
ON o.order_id = r.order_id
GROUP BY seller_id
ORDER BY average_review DESC;





## Q15 — Best-Selling Product Category
-- Identify the product category with the highest number of items sold. Return the category and its total number of sold items.

SELECT p.product_category_name, 
COUNT(o.order_item_id) AS total_items
FROM products AS p
INNER JOIN order_items AS o
ON p.product_id = o.product_id
GROUP BY product_category_name
ORDER BY total_items DESC
LIMIT 1;



## Q16 — Customers with at Least 5 Orders
-- Identify customers who have placed at least 5 orders. Return the customer ID and their total number of orders, showing the highest-order customers first.

SELECT c.customer_id,
COUNT(o.order_id) AS total_orders
FROM orders AS o
INNER JOIN customers AS c
ON o.customer_id = c.customer_id
GROUP BY c.customer_id
HAVING total_orders >= 5
ORDER BY total_orders DESC;






## Q17 — Orders with Total Payment Above 1000
-- Identify orders whose total recorded payment value exceeds 1,000. Calculate the total payment amount for each order and return only orders above 1,000.

SELECT order_id, 
SUM(payment_value) AS TOTAL_PAYMENT
FROM order_payments 
GROUP BY order_id
HAVING TOTAL_PAYMENT > 1000;







## Q18 — Average Payment Value by Payment Type
-- Calculate the average payment value for each payment type and rank the payment types based on their average payment value.

SELECT PAYMENT_TYPE,
AVG(PAYMENT_VALUE) AS average_paymnt
FROM order_payments
GROUP BY PAYMENT_TYPE
ORDER BY average_paymnt;







## Q19 — Order Volume by Customer State
-- Calculate the total number of orders placed by customers from each state and rank the states from highest to lowest order volume.

SELECT c.customer_state,
COUNT(order_id) AS total_orders
FROM customers AS c
INNER JOIN orders AS o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_state
ORDER BY total_orders DESC;







## Q20 — Top 10 Sellers by Items Sold
-- The Seller Management team wants to identify the top 10 sellers by number of products/items sold Calculate the number of order items for each seller and return the top 10 sellers.

SELECT 
    seller_id,
    COUNT(order_item_id) AS products_sold
FROM order_items
GROUP BY seller_id
ORDER BY products_sold DESC
LIMIT 10;







-- Q21 — Average Review by Score
-- The Customer Experience team wants to understand the distribution of customer feedback.
-- For each review score from 1 to 5, calculate how many reviews were submitted.

SELECT Review_Score, COUNT(Review_Score) AS Total_Reviews
FROM order_reviews
GROUP BY Review_Score
ORDER BY Total_Reviews DESC;






-- Q22 — Customers with No Orders
-- The CRM team wants to identify registered customers who have never placed an order. 
-- Find all customers who exist in the customer database but do not have any associated orders.

SELECT c.Customer_ID, o.order_id 
FROM customers AS c
LEFT JOIN orders AS o
ON c.Customer_ID = o.Customer_ID
WHERE order_id IS NULL;







-- Q23 — Sellers with No Products Sold
-- The Seller Management team wants to identify sellers who are registered on the platform but have not
-- yet sold any products. Find sellers who do not have any associated records in the order-item data.

SELECT  S.Seller_ID, O.order_item_ID FROM SELLERS AS S
LEFT JOIN ORDER_ITEMS AS O
ON S.Seller_ID = O.Seller_ID
WHERE order_item_ID IS NULL;






-- Q24 — Most Expensive Product
-- The Product team wants to identify the product with the highest listed price in the catalog. 
-- Find the product with the maximum product price and return its product ID and price.

   SELECT product_ID,  price
FROM ORDER_ITEMS
ORDER BY price DESC
LIMIT 1;
           
           
             
             
             
             
                                
-- Q24 — Highest-Priced Product Item
-- The Product team wants to identify the most expensive product item purchased through the platform.
-- Find the product ID associated with the highest item price recorded in the order-item data.

SELECT Product_ID, Price 
FROM ORDER_ITEMS 
ORDER BY Price DESC
LIMIT 1;








-- Q25 — Average Product Price by Category
-- The Product team wants to compare the average price of purchased products across different product 
-- categories. Calculate the average item price for each product category and rank the categories 
-- from highest to lowest average price.

SELECT  P.product_category_name,
AVG(O.Price) AS Average_Price 
FROM PRODUCTS AS P
LEFT JOIN ORDER_ITEMS AS O
ON P.Product_ID = O.Product_ID
GROUP BY product_category_name
ORDER BY Average_Price DESC;






 

-- Q26 — Freight Cost by Seller
-- The Seller Management team wants to understand the shipping cost associated with each seller.
--  Calculate the total freight value generated by each seller and identify the sellers with the 
-- highest total freight value.

SELECT Seller_ID, 
SUM(Freight_Value) AS Total_Freight_Value
FROM ORDER_ITEMS
GROUP BY Seller_ID
ORDER BY Total_Freight_Value DESC;

 
 
 
 

-- Q27 — Most Frequently Used Payment Method
-- The Payments team wants to understand customer payment preferences. Calculate the number of payments 
-- made using each payment type and rank the payment types from most frequently used to least frequently used.

SELECT PAYMENT_TYPE, COUNT(PAYMENT_TYPE) AS Total_Payments
FROM ORDER_PAYMENTS
GROUP BY PAYMENT_TYPE
ORDER BY Total_Payments DESC;
 
 
 
 


-- Q28 — Average Installment Count by Payment Type
-- The Finance team wants to understand how installment behavior differs across payment methods.
-- Calculate the average number of installments used for each payment type.

SELECT payment_type, AVG(payment_installments) AS average_installments
FROM ORDER_PAYMENTS
GROUP BY payment_type
ORDER BY average_installments;







-- Q29 — Orders with Multiple Payment Records
-- The Finance team wants to identify orders that were associated with more than one payment record.
-- Find the order IDs that have multiple payment entries in the payment data.

SELECT Order_ID, COUNT(PAYMENT_VALUE) AS multiple_payment
FROM ORDER_PAYMENTS
GROUP BY Order_ID
HAVING multiple_payment> 1;






-- Q30 — Average Order Value by Customer State
-- The Finance team wants to compare customer spending across different states. 
-- Calculate the average payment value of orders placed by customers from each state and rank the 
-- states from highest to lowest average payment value.

SELECT c.customer_state, AVG(payment_value) AS average_payment
FROM customers AS c
LEFT JOIN orders AS o
ON c.customer_ID = o.customer_ID
INNER JOIN order_payments AS p
ON o.order_id = p.order_id
GROUP BY customer_state
ORDER BY average_payment DESC;







-- Q31 — Products with Multiple Photos
-- The Product team wants to understand how many products have more than 3 product photos.
 -- Calculate the number of products in each photo-count group and identify the groups 
 -- where the number of photos is greater than 3.
 
SELECT product_photos_qty,
COUNT(product_id) AS  total_products
FROM products
GROUP BY product_photos_qty
HAVING product_photos_qty > 3
ORDER BY product_photos_qty DESC;






-- Q32 — Seller Order-Item Volume
-- The Seller Management team wants to compare seller activity based on the number of
 -- products/items sold. Calculate the total number of order items associated with each
--  seller and return the top 10 sellers by order-item volume.

SELECT Seller_ID, COUNT(order_item_id) AS total_items
FROM order_items
GROUP BY Seller_ID
ORDER BY total_items DESC
limit 10 ;







-- Q33 — Average Product Weight by Category
-- The Product team wants to understand the physical characteristics of products across 
-- categories. Calculate the average product weight for each product category and rank the 
-- categories from heaviest to lightest on average.

SELECT product_category_name,
AVG(product_weight_g) AS average_product_weight
FROM products
GROUP BY product_category_name
ORDER BY average_product_weight DESC;






-- Q34 — Customer Order Volume by State
-- The Operations team wants to understand which customer states generate the highest order volume. Calculate the total number of orders placed by customers from each state and rank the states from highes to lowest.

SELECT c.customer_state,
COUNT(o.order_id) AS Total_orders
FROM customers AS c
INNER JOIN orders AS o
ON c.customer_id = o.customer_id
GROUP BY c.customer_state
ORDER BY Total_orders DESC;






-- Q35 — Average Review Score by Order Status
-- The Customer Experience team wants to understand whether customer satisfaction differs
-- across order statuses. Calculate the average review score for each order status.

SELECT o.order_status,
AVG(r.review_score) AS averagr_review
FROM order_reviews AS r
INNER JOIN orders AS o
ON r.order_id = o.order_id
GROUP BY order_status;






-- Q36 — Sellers with High Average Item Prices
-- The Seller Management team wants to identify sellers whose products have a relatively 
-- high average item price. Calculate the average item price for each seller and return only
--  sellers whose average item price is greater than 200.

SELECT seller_id,
AVG(PRICE) AS average_price
FROM order_items
GROUP BY seller_id
HAVING average_price > 200 
ORDER BY average_price DESC;





-- Q37 — Monthly Revenue from Product Items
-- The Finance team wants to analyze how the value of purchased products changes over time.
-- Calculate the total item price for each month of each year based on the order purchase date.

SELECT YEAR(o.order_purchase_timestamp) AS YEAR,
MONTH(o.order_purchase_timestamp) AS MONTH,
SUM(ot.Price) AS Total_Price
FROM orders AS o
INNER JOIN order_items AS ot
ON o.order_id = ot.order_id
GROUP BY YEAR, MONTH
ORDER BY YEAR, MONTH DESC;






-- Q38 — Review Performance by State
-- The Customer Experience team wants to compare customer satisfaction across states. 
-- Calculate the average review score for each customer state and rank the states from
-- highest to lowest average review score

SELECT c.customer_state, 
AVG(r.review_score) AS average_review
FROM customers AS c
INNER JOIN  orders AS o
ON c.customer_id = o.customer_id
INNER JOIN order_reviews AS r
ON o.order_id = r.order_id
GROUP BY customer_state
ORDER BY average_review DESC;






-- Q39 — Total Order Cost Including Freight
-- The Finance team wants to estimate the total value associated with each order by 
-- combining the product item price and freight value. Calculate the total item price, 
-- total freight value, and combined total cost for each order.

SELECT order_id,
SUM(price) AS item_price,
SUM(freight_value) AS freight_value,
SUM(price) + SUM(freight_value) AS Total_Cost
FROM order_items
GROUP BY order_id;


 







-- Q40 — Delivery Performance
-- The Operations team wants to evaluate how efficiently orders are being delivered. Calculate the average number
-- of days between the order purchase date and the actual customer delivery date for each order status.

SELECT order_status, 
AVG(datediff(order_delivered_customer_date, order_purchase_timestamp)) AS average_delivery_days
FROM orders 
GROUP BY order_status
ORDER BY average_delivery_days;






-- Q41 — Late Delivery Analysis
-- The Logistics team wants to identify orders that were delivered later than the originally 
-- estimated delivery date. Calculate the number of orders that were delivered after their
-- estimated delivery date.

SELECT order_estimated_delivery_date, order_delivered_customer_date
FROM orders
WHERE  order_delivered_customer_date > order_estimated_delivery_date;
 




-- Q42 — Late Delivery Rate by Customer State
-- The Operations team wants to understand whether delivery delays are concentrated in particular 
-- customer states. For each customer state, calculate the total number of delivered orders and 
-- the number of orders delivered after the estimated delivery date.

SELECT c.customer_state, COUNT(order_delivered_customer_date) AS delivered_orders,
SUM( CASE
   WHEN
  order_delivered_customer_date > order_estimated_delivery_date
  THEN 1
  ELSE 0
END ) AS late_delivery
 FROM customers AS c
INNER JOIN orders AS o 
ON c.customer_id = o.customer_id
GROUP BY customer_state;






-- Q43 — Review Response Coverage
-- The Customer Experience team wants to know what proportion of orders received a customer review.
-- Calculate the total number of orders and the number of orders that have at least one review record.

SELECT COUNT(DISTINCT O.order_id) AS total_orders,
COUNT(DISTINCT r.order_id) AS order_with_review
FROM orders AS o
LEFT JOIN order_reviews AS r
ON o.order_id = r.order_id;




-- Q44 — Low-Rated Orders
-- The Customer Experience team wants to investigate poorly rated orders. Identify the orders that received a 
-- review score of 1 or 2, along with their customer IDs and order status.

SELECT o.order_id, o.customer_id, o.order_status, r.review_score
FROM orders AS o
INNER JOIN order_reviews AS r
ON o.order_id = r.order_id
WHERE  r.review_score IN(1, 2);



-- Q45 — Payment Value vs Item Value
-- The Finance team wants to compare the recorded payment value of each order with the total value of its 
-- purchased items. Calculate, for each order, the total item price and total payment value.

SELECT o.order_id, 
o.total_price,
p.total_payment_value
FROM
( SELECT order_id,  
SUM(price) AS total_price
FROM order_items
GROUP BY order_id) AS o
LEFT JOIN 
(
SELECT order_id,
 SUM(payment_value) AS total_payment_value
 FROM order_payments
 GROUP BY order_id ) AS p
ON o.order_id = p.order_id;








-- Q46 — Orders with High Freight Burden
-- The Logistics team wants to identify orders where the total freight cost is greater than the total item price.
--  Return the order ID, total item price, and total freight value for such orders.

SELECT order_ID, 
SUM(freight_value) AS total_freight_value,
SUM(price) AS total_item_price
FROM order_items
GROUP BY order_ID
HAVING total_freight_value > total_item_price;





-- Q47 — Product Category Translation Coverage
-- The Product team wants to assess how many product categories have an English category translation available. 
-- Compare the total number of unique product categories in the product data with the number of categories 
-- available in the translation table.

SELECT 
COUNT(DISTINCT P.Product_category_name) AS unique_product_categories,
COUNT(DISTINCT t.product_category_name) AS translated_categories
FROM products AS P
LEFT JOIN product_category_translation AS t
ON P.Product_category_name = t.Product_category_name;







-- Q48 — Seller Geographic Distribution
-- The Seller Operations team wants to understand where sellers are concentrated. Calculate the number of sellers
-- in each seller state and identify the states containing more than 50 sellers.

SELECT seller_state, COUNT(seller_id) AS Total_sellers
FROM sellers
GROUP BY seller_state
HAVING Total_sellers > 50;




-- Q49 — Product Dimension Analysis
-- The Product team wants to identify product categories containing products with an 
-- average weight greater than 5,000 grams. Calculate the average product weight for each category and 
-- return only categories above this threshold.

SELECT product_category_name, AVG(product_weight_g) AS avg_weight
FROM products
GROUP BY product_category_name
HAVING avg_weight > 5000;




-- Q50 — Orders by Delivery Status Pattern
-- The Operations team wants to understand the relationship between order status and delivery information.
-- For each order status, calculate how many orders have an actual customer delivery date recorded.

SELECT  order_status, 
COUNT(order_delivered_customer_date) AS actual_date 
FROM orders
GROUP BY order_status;




-- Q51 — High-Value Customers
-- The Customer Analytics team wants to identify customers whose total recorded payment value exceeds 5,000. 
-- Calculate the total payment value for each customer and return only customers above this threshold.


SELECT o.customer_id, 
SUM(p.payment_value) AS total_payment_value 
FROM orders AS o
INNER JOIN order_payments AS p
ON o.order_id = p.order_id
GROUP BY o.customer_id
HAVING total_payment_value > 5000;




-- Q52 — Customer Order Status Mix
-- The Operations team wants to understand the order-status mix of individual customers. 
-- For each customer, calculate the number of orders they have in each order status.

SELECT customer_id, order_status,
COUNT(order_id) AS total_orders
FROM orders
GROUP BY order_status, customer_id;




-- Q53 — Seller Product Category Exposure
-- The Seller Management team wants to understand which product categories each seller is selling. 
-- Return each seller ID along with the distinct product categories associated with their sold items.

SELECT  DISTINCT 
p.product_category_name,
o.seller_ID
FROM products AS p  
INNER JOIN order_items AS o       
ON p.product_id = o.product_id;     






-- Q54 — Customer Purchase Activity by Year
-- The Customer Analytics team wants to compare customer purchasing activity across years. For each year,
-- calculate the number of unique customers who placed at least one order.

SELECT COUNT(DISTINCT customer_id) AS  unique_customers,
YEAR(order_purchase_timestamp) AS year
FROM orders
GROUP BY YEAR(order_purchase_timestamp)
ORDER BY unique_customers;





-- Q55 — Product Categories with Strong Customer Ratings
-- The Product team wants to identify product categories associated with strong customer satisfaction. 
-- Calculate the average review score for each product category and return only categories with an average score 
-- of at least 4.

SELECT 
p.product_category_name,
AVG(r.review_score) AS  average_review
FROM products AS p
INNER JOIN order_items AS o
ON p.product_id = o.product_id
INNER JOIN order_reviews AS r
ON o.order_id = r.order_id
GROUP BY product_category_name
HAVING average_review >= 4;




-- Q56 — Customer Repeat Purchase Analysis 🟡 Medium
-- The Customer Retention team wants to identify customers who placed more than one order on the platform. 
-- Find each customer and the number of orders they placed, showing only customers with at least 2 orders.

SELECT customer_id, COUNT(order_id) AS total_orders
FROM orders
GROUP BY  customer_id
HAVING total_orders >= 2;





-- Q57 — Seller Product Portfolio 🟡 Medium
-- The Seller Management team wants to understand how many different products each seller has sold. Find the 
-- number of unique products sold by each seller and rank sellers from highest to lowest.

SELECT seller_id,
COUNT(DISTINCT product_id) AS unique_products
FROM order_items
GROUP BY seller_id
ORDER BY unique_products DESC;






-- Q58 — Delivery Performance by Customer State 🟠 Medium–Advanced
-- The Logistics team wants to compare delivery performance across customer states. Calculate the average number
-- of days taken to deliver orders for each customer state, considering only orders that were actually delivered.

SELECT c.customer_state,
AVG(datediff(o.order_delivered_customer_date, o.order_purchase_timestamp)) AS average_delivery_days
FROM customers AS c
INNER JOIN  orders AS O
ON c.customer_id = o.customer_id
WHERE order_delivered_customer_date IS NOT NULL
GROUP BY customer_state
ORDER BY average_delivery_days ;    





-- Q59 — High-Value Orders 🟠 Advanced
-- The Finance team wants to identify high-value orders based on their total item value.
-- Find orders whose total item price is greater than the average total item price across all orders.

SELECT order_id,
 total_price FROM
(
SELECT order_id,
SUM(price) AS total_price 
FROM order_items
GROUP BY order_id
) AS total_orders

WHERE total_price > 
( SELECT AVG(total_price)
FROM
(
SELECT order_id,
SUM(price) AS total_price 
FROM order_items
GROUP BY order_id
) AS order_average )
ORDER BY total_price DESC;





-- Q60 — Seller Performance Comparison 🔴 Advanced
-- The Business team wants to identify sellers whose average product price is higher than the overall average product
--  price across all sold items. Find those sellers and compare their average price with the overall marketplace average.

SELECT seller_id, seller_average_price
FROM
(SELECT seller_id,
AVG(price) AS seller_average_price 
FROM order_items
GROUP BY seller_id) AS total_price 
 
WHERE seller_average_price > 
( SELECT 
AVG(price) AS average_price
FROM order_items )
ORDER BY seller_average_price DESC;





-- Q61. Customer Spending Analysis
-- The Marketing team wants to identify customers who have spent more than ₹1,000 in total product purchases. 
-- Find their customer_id and total amount spent, sorted from highest to lowest.

SELECT o.customer_id, 
SUM(P.total_amount_spent) AS total_amount_spent
FROM ( SELECT order_id,
SUM(p.payment_value) AS total_amount_spent
FROM order_payments AS p
GROUP BY order_id
)  AS p
INNER JOIN orders AS o
ON p.order_id = o.order_id
GROUP BY customer_id
HAVING total_amount_spent > 1000
ORDER BY total_amount_spent DESC;


                    
                    
                    
--  Q62. Category Sales Performance
-- The Product team wants to understand which product categories generate the highest sales. Find each
-- product category and its total product sales, sorted from highest to lowest.

SELECT 
p.product_category_name,
SUM(o.price) AS total_sales 
FROM order_items AS o
INNER JOIN products AS p
ON p.product_id = o.product_id
GROUP BY p.product_category_name
ORDER BY total_sales DESC;






-- Q63. Seller Order Volume
-- The Seller Management team wants to identify sellers handling the highest number of orders.
-- Find each seller_id and the number of unique orders associated with that seller.

SELECT  seller_id,
COUNT(DISTINCT order_id) AS total_orders
FROM order_items
GROUP BY seller_id
ORDER BY total_orders DESC;






-- Q64. Customers with High Order Frequency
-- The Retention team wants a list of customers who have placed at least 3 orders. 
-- Return customer_id and their total number of orders.

SELECT customer_id, 
COUNT(order_id) AS total_orders
FROM orders
GROUP BY customer_id
HAVING total_orders >= 3 ;







-- Q65. Payment Method Analysis
-- The Finance team wants to understand customer payment preferences. Find each payment_type,
-- the number of payments, and the total payment value generated through that payment method.

SELECT payment_type, 
COUNT(payment_type) AS total_payments,
SUM(payment_value) AS total_payments_value
FROM order_payments
GROUP BY payment_type;







-- Q66. Product Category Pricing
-- The Product team wants to compare pricing across categories. Find each product category and
-- its average product price, showing only categories where the average price is greater than ₹200.

SELECT p.product_category_name,
AVG(o.price) AS average_price
FROM products AS p
INNER JOIN order_items AS o
ON p.product_id = o.product_id
GROUP BY product_category_name
HAVING average_price > 200
ORDER BY average_price DESC;






-- Q67. Seller Freight Burden
-- The Operations team wants to identify sellers with high shipping costs. Find sellers whose 
-- total freight value is greater than ₹500, along with their total freight value.

SELECT seller_id,
SUM(freight_value) AS total_freight_value
FROM order_items
GROUP BY seller_id
HAVING total_freight_value > 500;






-- Q68. Review Performance
-- The Customer Experience team wants to identify sellers whose products received 
-- an average review score of at least 4. Return seller_id and average review score.

SELECT o.seller_id,
AVG(r.review_score) AS average_review_score
FROM order_items AS o
INNER JOIN order_reviews AS r
ON o.order_id = r.order_id
GROUP BY seller_id
HAVING average_review_score >= 4;






-- Q69. Customer State Sales
-- The Business team wants to know which customer states generate the most product sales. 
-- Find each customer_state and its total product purchase value.

SELECT c.customer_state,
SUM(r.price) AS total_value
FROM customers AS c
INNER JOIN orders AS o
ON c.customer_id = o.customer_id
INNER JOIN order_items AS r
ON o.order_id = r.order_id
GROUP BY customer_state;










-- Q70. Delivery Delay Analysis
-- The Logistics team wants to identify orders that were delivered after the estimated delivery date. 
-- Return the order_id, estimated delivery date, and actual delivery date.

SELECT order_id, 
order_delivered_customer_date,
order_estimated_delivery_date
FROM orders
WHERE order_estimated_delivery_date > order_purchase_timestamp;





USE ecommerce_project;


-- Q71. Above-Average Sellers
-- Management wants to identify sellers whose average product price is higher than the
-- overall average product price across all sold items.

SELECT seller_id, seller_average_price
FROM
( SELECT seller_id,
AVG(price) AS seller_average_price
FROM order_items
GROUP BY seller_id
) AS total_price
WHERE seller_average_price >
(SELECT
AVG(price) AS avaerage_price
FROM order_items
 ) 
ORDER BY seller_average_price DESC;




SELECT seller_id, seller_average_price
FROM
(SELECT seller_id,
AVG(price) AS seller_average_price 
FROM order_items
GROUP BY seller_id) AS total_price 
 
WHERE seller_average_price > 
( SELECT 
AVG(price) AS average_price
FROM order_items )
ORDER BY seller_average_price DESC;







-- Q72. High-Spending Customers
-- The Marketing team wants to target customers whose total spending is higher than the average customer spending.

SELECT customer_id,
customers_spending
FROM (
SELECT o.customer_id,
SUM(r.price) AS customers_spending
FROM orders AS o 
INNER JOIN order_items AS r
ON o.order_id = r.order_id 
GROUP BY customer_id ) AS total_spending
WHERE customers_spending > 
 ( SELECT AVG(customers_spending)
 FROM(
SELECT o.customer_id,
AVG(r.price) AS average_spending
FROM orders AS o 
INNER JOIN order_items AS r
ON o.order_id = r.order_id 
GROUP BY customer_id ) AS total_average_spending
)
ORDER BY customers_spending DESC;





-- Q73. Top-Selling Product per Seller
-- The Seller Management team wants to know which product each seller has sold the highest number of times.

SELECT seller_id, product_id,
sold_products FROM (
SELECT seller_id, product_id,
COUNT(*) AS sold_products,
RANK() OVER(PARTITION BY seller_id ORDER BY COUNT(*) DESC) AS product_rank

FROM order_items
GROUP BY seller_id, product_id) AS ranked_products
WHERE product_rank = 1
ORDER BY seller_id DESC;








-- Q74. Category Above Overall Average
-- The Product team wants to identify product categories whose average product price is higher than the overall average product price.

SELECT category_average.product_category_name,
average_product_price
FROM ( SELECT p.product_category_name,
AVG(o.price) AS average_product_price
FROM products  AS p
INNER JOIN order_items AS o
ON p.product_id = o.product_id
GROUP BY product_category_name) AS category_average

WHERE average_product_price >
( SELECT 
AVG(o.price) AS average_priceS
FROM order_items AS o)
ORDER BY average_product_price DESC ;










-- Q75. Customers with Above-Average Order Value
-- The Marketing team wants to identify customers whose average order value is higher than the average order value across all customers.

SELECT customer_id,
       average_order_value
FROM
(
    SELECT customer_id,
           AVG(order_total) AS average_order_value
    FROM
    (
        SELECT o.customer_id,
               o.order_id,
               SUM(oi.price) AS order_total
        FROM orders AS o
        INNER JOIN order_items AS oi
        ON o.order_id = oi.order_id
        GROUP BY o.customer_id, o.order_id
    ) AS order_totals
    GROUP BY customer_id
) AS customers_average

WHERE average_order_value >
(
    SELECT AVG(average_order_value)
    FROM
    (
        SELECT customer_id,
               AVG(order_total) AS average_order_value
        FROM
        (
            SELECT o.customer_id,
                   o.order_id,
                   SUM(oi.price) AS order_total
            FROM orders AS o
            INNER JOIN order_items AS oi
            ON o.order_id = oi.order_id
            GROUP BY o.customer_id, o.order_id
        ) AS order_totals
        GROUP BY customer_id
    ) AS customer_averages
)
ORDER BY average_order_value DESC;









-- Q76. Seller Revenue Contribution
-- Management wants to understand seller contribution to total sales.
-- For every seller, calculate:

SELECT seller_id,
SUM(price) AS seller_total_sales
FROM order_items
GROUP BY seller_id
ORDER BY seller_total_sales DESC;


 










-- Q77. Repeat Customer Revenue
-- The Retention team wants to compare spending between repeat and one-time customers.
-- Identify customers who have placed more than one order, and calculate their total spending.

SELECT o.customer_id,
COUNT(DISTINCT o.order_id) AS number_of_orders,
SUM(r.price) total_of_orders
FROM orders AS o
INNER JOIN order_items AS r
ON o.order_id = r.order_id
GROUP BY customer_id
HAVING number_of_orders >1
ORDER BY total_of_orders DESC;







-- Q78. Products with Above-Average Sales
-- The Product team wants to identify products whose total sales value is higher than the average product sales value.

SELECT product_id, total_sales
FROM(
SELECT product_id,
SUM(price) AS total_sales
FROM order_items 
GROUP BY product_id ) AS total_product_sales

WHERE total_sales >
( SELECT
AVG(total_sales)
FROM(
SELECT product_id,
SUM(price) AS total_sales
FROM order_items 
GROUP BY product_id ) 
AS average_product_sales);






-- Q79. State with Highest Average Order Value
-- The Business team wants to compare customer states based on their average order value.
-- For each state, calculate:

SELECT c.customer_state,
AVG(p.price) AS average_order_value
FROM customers AS c 
INNER JOIN orders AS o
ON c.customer_id = o.customer_id
INNER JOIN order_items AS p
ON o.order_id = p.order_id
GROUP BY customer_state
ORDER BY average_order_value DESC;







-- Q80. Seller Performance Ranking
-- Management wants a seller performance report containing:
-- Only include sellers who have handled at least 5 unique orders.
-- Sort the final result by total sales from highest to lowest.

SELECT seller_id,
COUNT(DISTINCT order_id) AS total_orders,
SUM( price) AS total_sales,
AVG( price) AS average_product_price
FROM order_items
GROUP BY seller_id
HAVING total_orders >= 5
ORDER BY total_sales DESC;
































