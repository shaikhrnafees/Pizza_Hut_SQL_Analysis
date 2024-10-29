--Calculate the total revenue generated from pizza sales.

select sum(p.price* o.quantity) as total_revenue 
from pizzas p
left join order_details o 
on p.pizza_id=o.pizza_id