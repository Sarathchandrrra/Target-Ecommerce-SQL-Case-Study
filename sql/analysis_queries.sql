-- SQL queries used for the Target e-commerce case study
-- These queries assume the Olist Brazilian E-Commerce Public Dataset schema

-- 1. Number of orders by order status
SELECT order_status, COUNT(*) AS num_orders
FROM olist_orders_dataset
GROUP BY order_status
ORDER BY num_orders DESC;

-- 2. Annual revenue across all orders
SELECT EXTRACT(YEAR FROM o.order_purchase_timestamp) AS year,
       SUM(oi.price + oi.freight_value) AS total_revenue
FROM olist_orders_dataset o
JOIN olist_order_items_dataset oi
  ON o.order_id = oi.order_id
WHERE o.order_status = 'delivered'
GROUP BY year
ORDER BY year;

-- 3. Top 5 product categories by revenue
SELECT p.product_category_name,
       SUM(oi.price) AS revenue
FROM olist_order_items_dataset oi
JOIN olist_products_dataset p
  ON oi.product_id = p.product_id
GROUP BY p.product_category_name
ORDER BY revenue DESC
LIMIT 5;

-- 4. Average delivery time in days
SELECT AVG(DATE(o.order_delivered_customer_date) - DATE(o.order_purchase_timestamp)) AS avg_delivery_days
FROM olist_orders_dataset o
WHERE o.order_status = 'delivered';
