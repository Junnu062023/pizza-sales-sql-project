
CREATE DATABASE IF not exists pizza_sales;
 use pizza_sales;
 create database if not exists pizza_sales;
drop database if exists pizza_sales;
create database pizza_sales;
use pizza_sales;
CREATE TABLE orders (
  order_id VARCHAR(50) PRIMARY KEY,
  date DATE,
  time TIME
);

CREATE TABLE order_details (
  order_details_id INT PRIMARY KEY,
  order_id VARCHAR(50),
  pizza_id VARCHAR(50),
  quantity INT
);

CREATE TABLE pizzas (
  pizza_id VARCHAR(50) PRIMARY KEY,
  pizza_type_id VARCHAR(50),
  size VARCHAR(10),
  price DECIMAL(5,2)
);

CREATE TABLE pizza_types (
  pizza_type_id VARCHAR(50) PRIMARY KEY,
  name VARCHAR(100),
  category VARCHAR(50),
  ingredients TEXT
);

SELECT * FROM pizzas LIMIT 5;
SELECT * FROM orders LIMIT 5;
SELECT * FROM order_details LIMIT 5;
SELECT * FROM pizza_types LIMIT 5;

# 1. Total number of orders

SELECT COUNT(order_id) FROM orders;

# 2. Total revenue

SELECT ROUND(SUM(order_details.quantity * pizzas.price), 2) AS Total_Sales
FROM order_details
JOIN pizzas ON pizzas.pizza_id = order_details.pizza_id;

# 3. Highest priced pizza

SELECT pizza_types.name, pizzas.price 
FROM pizza_types
JOIN pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
ORDER BY pizzas.price DESC
LIMIT 1;

#  4. Most common pizza size ordered

SELECT pizzas.size, COUNT(order_details.order_details_id) AS Total_Count
FROM pizzas
JOIN order_details ON pizzas.pizza_id = order_details.pizza_id
GROUP BY pizzas.size
ORDER BY Total_Count DESC
LIMIT 1;

# 5. Top 5 most ordered pizza types

SELECT pizza_types.name, SUM(order_details.quantity) AS quantity
FROM pizza_types
JOIN pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
JOIN order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.name
ORDER BY quantity DESC
LIMIT 5;

# 6. Total quantity by pizza category

SELECT pizza_types.category, SUM(order_details.quantity) AS quantity
FROM pizza_types
JOIN pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
JOIN order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.category
ORDER BY quantity DESC;

#  7. Order distribution by hour

SELECT HOUR(time) AS order_hour, COUNT(order_id) AS order_count
FROM orders
GROUP BY HOUR(time)
ORDER BY order_hour;

#  8. Pizza count per category

SELECT category, COUNT(name) AS pizza_count
FROM pizza_types
GROUP BY category;

#  Query 9: Average number of pizzas ordered per day

SELECT 
  date,
  SUM(order_details.quantity) AS total_pizzas,
  ROUND(AVG(order_details.quantity), 2) AS avg_pizzas_per_order
FROM orders
JOIN order_details ON orders.order_id = order_details.order_id
GROUP BY date
ORDER BY date;

# Query 10: Top 3 most ordered pizza types based on revenue

SELECT 
  pizza_types.name,
  ROUND(SUM(order_details.quantity * pizzas.price), 2) AS total_revenue
FROM pizza_types
JOIN pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
JOIN order_details ON pizzas.pizza_id = order_details.pizza_id
GROUP BY pizza_types.name
ORDER BY total_revenue DESC
LIMIT 3;

#  Query 11: Percentage contribution of each pizza type to total revenue

WITH revenue_by_type AS (
  SELECT 
    pizza_types.name,
    SUM(order_details.quantity * pizzas.price) AS revenue
  FROM pizza_types
  JOIN pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
  JOIN order_details ON pizzas.pizza_id = order_details.pizza_id
  GROUP BY pizza_types.name
),
total_revenue AS (
  SELECT SUM(revenue) AS total FROM revenue_by_type
)
SELECT 
  r.name,
  ROUND((r.revenue / t.total) * 100, 2) AS revenue_percentage
FROM revenue_by_type r, total_revenue t
ORDER BY revenue_percentage DESC;

# Query 12: Cumulative revenue over time

SELECT 
  o.date,
  ROUND(SUM(od.quantity * p.price), 2) AS daily_revenue,
  ROUND(SUM(SUM(od.quantity * p.price)) OVER (ORDER BY o.date), 2) AS cumulative_revenue
FROM orders o
JOIN order_details od ON o.order_id = od.order_id
JOIN pizzas p ON p.pizza_id = od.pizza_id
GROUP BY o.date
ORDER BY o.date;

# Query 13: Top 3 revenue-generating pizza types per category

WITH category_revenue AS (
  SELECT 
    pt.category,
    pt.name,
    SUM(od.quantity * p.price) AS revenue
  FROM pizza_types pt
  JOIN pizzas p ON pt.pizza_type_id = p.pizza_type_id
  JOIN order_details od ON od.pizza_id = p.pizza_id
  GROUP BY pt.category, pt.name
),
ranked_revenue AS (
  SELECT *,
         RANK() OVER (PARTITION BY category ORDER BY revenue DESC) AS revenue_rank
  FROM category_revenue
)
SELECT category, name, ROUND(revenue, 2) AS revenue
FROM ranked_revenue
WHERE revenue_rank <= 3
ORDER BY category, revenue DESC;


SELECT * FROM orders;
SELECT * FROM order_details;
SELECT * FROM pizzas;
SELECT * FROM pizza_types;
