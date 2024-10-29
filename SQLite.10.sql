--Determine the top 3 most ordered pizza types based on revenue.

select t.name , sum(o.quantity*p.price) as revenue 
from order_details o 
left join pizzas p on o.pizza_id=p.pizza_id
left join pizza_types t on p.pizza_type_id=t.pizza_type_id
GROUP by t.name
order by revenue DESC
limit 3