--Group the orders by date and calculate the average number of pizzas ordered per day.

with temp1 as ( select o.date,sum(d.quantity) as Total_order from orders o 
                left join order_details d 
                on o.order_id=d.order_id
                GROUP by  date )

select date,round(avg(total_order),2) as Avegrage_Pizza_per_day
from temp1
GROUP by date
order by date asc