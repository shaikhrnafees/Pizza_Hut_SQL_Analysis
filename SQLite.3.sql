--Identify the most common pizza size ordered.

select p.size,count(o.order_id) as size_order 
from pizzas p
left join order_details o 
on o.pizza_id=p.pizza_id
group by p.size
order by size_order desc