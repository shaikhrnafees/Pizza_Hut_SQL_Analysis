--Determine the distribution of orders by hour of the day.
select strftime('%H',time) as hour, count(order_id) as distrbution_of_order
from orders
group by hour
order by hour asc