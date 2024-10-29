--List the top 5 most ordered pizza types along with their quantities.

select p.pizza_type_id ,sum(o.quantity) as Top_5_Most
from order_details o
left join pizzas p 
on o.pizza_id=p.pizza_id
GROUP by p.pizza_type_id
order by top_5_most desc
limit 5;