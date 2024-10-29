--Analyze the cumulative revenue generated over time.

select o.date, sum(o2.quantity*p.price) as revenue
      ,SUM(SUM(o2.quantity * p.price)) OVER (ORDER BY o.date) AS cumulative_revenue
from orders o 
left join  order_details o2 on o.order_id=o2.order_id
left join pizzas p on o2.pizza_id=p.pizza_id
left join pizza_types t on t.pizza_type_id=p.pizza_type_id 
group by o.date
order by o.date