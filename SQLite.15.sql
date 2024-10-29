-- Retrieve the total number of orders placed.
SELECT COUNT(order_id) AS total_number_of_orders 
FROM orders;

-- Calculate the total revenue generated from pizza sales.
SELECT SUM(p.price * o.quantity) AS total_revenue 
FROM pizzas p
LEFT JOIN order_details o ON p.pizza_id = o.pizza_id;

-- Identify the highest-priced pizza.
SELECT t.pizza_type_id, MAX(p.price) AS High_Priced_Pizza
FROM pizza_types t
LEFT JOIN pizzas p ON t.pizza_type_id = p.pizza_type_id
GROUP BY t.pizza_type_id
ORDER BY High_Priced_Pizza DESC
LIMIT 1;

-- Identify the most common pizza size ordered.
SELECT p.size, COUNT(o.order_id) AS size_order 
FROM pizzas p
LEFT JOIN order_details o ON o.pizza_id = p.pizza_id
GROUP BY p.size
ORDER BY size_order DESC;

-- List the top 5 most ordered pizza types along with their quantities.
SELECT p.pizza_type_id, SUM(o.quantity) AS Top_5_Most
FROM order_details o
LEFT JOIN pizzas p ON o.pizza_id = p.pizza_id
GROUP BY p.pizza_type_id
ORDER BY Top_5_Most DESC
LIMIT 5;

-- Join the necessary tables to find the total quantity of each pizza category ordered.
SELECT t.category, SUM(o.quantity) AS Quant 
FROM order_details o 
LEFT JOIN pizzas p ON o.pizza_id = p.pizza_id
LEFT JOIN pizza_types t ON p.pizza_type_id = t.pizza_type_id
GROUP BY t.category
ORDER BY Quant DESC;

-- Determine the distribution of orders by hour of the day.
SELECT strftime('%H', o.time) AS hour, COUNT(o.order_id) AS distribution_of_order
FROM orders o
GROUP BY hour
ORDER BY hour ASC;

-- Group the orders by date and calculate the average number of pizzas ordered per day.
WITH temp1 AS (
    SELECT o.date, SUM(d.quantity) AS Total_order 
    FROM orders o 
    LEFT JOIN order_details d ON o.order_id = d.order_id
    GROUP BY o.date
)
SELECT date, ROUND(AVG(Total_order), 2) AS Average_Pizza_per_day
FROM temp1
GROUP BY date
ORDER BY date ASC;

-- Determine the top 3 most ordered pizza types based on revenue.
SELECT t.name, SUM(o.quantity * p.price) AS revenue 
FROM order_details o 
LEFT JOIN pizzas p ON o.pizza_id = p.pizza_id
LEFT JOIN pizza_types t ON p.pizza_type_id = t.pizza_type_id
GROUP BY t.name
ORDER BY revenue DESC
LIMIT 3;

-- Calculate the percentage contribution of each pizza type to total revenue.
WITH temp1 AS (
    SELECT t.name, SUM(o.quantity * p.price) AS revenue
    FROM order_details o 
    LEFT JOIN pizzas p ON o.pizza_id = p.pizza_id
    LEFT JOIN pizza_types t ON p.pizza_type_id = t.pizza_type_id
    GROUP BY t.name
)
SELECT name, revenue, ROUND((revenue / SUM(revenue) OVER ()) * 100, 2) AS percent
FROM temp1;

-- Analyze the cumulative revenue generated over time.
SELECT o.date, 
       SUM(o2.quantity * p.price) AS revenue,
       SUM(SUM(o2.quantity * p.price)) OVER (ORDER BY o.date) AS cumulative_revenue
FROM orders o 
LEFT JOIN order_details o2 ON o.order_id = o2.order_id
LEFT JOIN pizzas p ON o2.pizza_id = p.pizza_id
LEFT JOIN pizza_types t ON t.pizza_type_id = p.pizza_type_id 
GROUP BY o.date
ORDER BY o.date;

-- Determine the top 3 most ordered pizza types based on revenue for each pizza category.
SELECT t.category, t.name, SUM(o.quantity * p.price) AS revenue,
       COUNT(o.quantity) AS order_Count
FROM order_details o 
LEFT JOIN pizzas p ON o.pizza_id = p.pizza_id
LEFT JOIN pizza_types t ON p.pizza_type_id = t.pizza_type_id
GROUP BY t.category, t.name
ORDER BY revenue DESC
LIMIT 3;
