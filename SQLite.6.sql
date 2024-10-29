--Join the necessary tables to find the total quantity of each pizza category ordered.

select t.category, sum(o.quantity) as Quant 
from order_details o 
left join pizzas p 
on o.pizza_id=p.pizza_id
left join pizza_types t 
on p.pizza_type_id=t.pizza_type_id
group by t.category
order by quant desc