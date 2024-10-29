--Identify the highest-priced pizza.

SELECT t.pizza_type_id,p.price AS High_Demand
FROM pizza_types t
LEFT JOIN pizzas p 
ON t.pizza_type_id = p.pizza_type_id
order by p.price DESC;
