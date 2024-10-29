--Calculate the percentage contribution of each pizza type to total revenue.
with temp1 as (
select *,t.name , sum(o.quantity*p.price) as revenue
from order_details o 
left join pizzas p on o.pizza_id=p.pizza_id
left join pizza_types t on p.pizza_type_id=t.pizza_type_id
GROUP by t.name
order by revenue DESC)

select name, revenue , round((revenue/sum(revenue) over())* 100,2) as percent
from temp1;