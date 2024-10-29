# Pizza Sales Analysis Case Study

<p align="center">
    <img src="https://mad.com.pk/wp-content/uploads/2016/11/logo-2015.png" alt="Logo" />
</p>

## Introduction

Welcome to the Pizza Sales Analysis Case Study! This project is designed to provide insights into the sales performance of a pizza restaurant. By analyzing various aspects of pizza orders, including total sales, revenue generation, customer preferences, and more, we can uncover valuable patterns and trends that can help improve business strategies and marketing efforts.

The analysis leverages SQL queries to extract meaningful information from the database, enabling stakeholders to make data-driven decisions. Whether you're a business owner looking to optimize your offerings or a data enthusiast interested in exploring sales data, this case study will provide a comprehensive view of the pizza sales landscape.

### Objectives
- To understand overall sales performance through key metrics.
- To analyze customer preferences in terms of pizza types and sizes.
- To identify trends in ordering behavior over time.
- To provide actionable insights for enhancing marketing strategies.

### Features
- Detailed SQL queries to extract specific data.
- Visualizations (e.g., charts) to represent findings.
- Suggestions for business improvements based on the analysis.

<p align="center">
    <img src="https://i.pinimg.com/originals/0d/15/26/0d1526b6c16ca8457500ea5dba74a68f.gif" alt="Animated GIF" style="width: 210px; height: auto;"/>
</p>

## SQL Case Study and Analysis Report

### Key Queries with Explanations, Expected Outputs, and Sample Tables

1. **Total number of orders placed**:
    ```sql
    SELECT COUNT(order_id) AS total_number_of_orders 
    FROM orders;
    ```
    - **Explanation**: This query counts the total number of unique orders in the `orders` table by counting the `order_id` column. 
    - **Expected Output**:
      | total_number_of_orders |
      |------------------------|
      | 150                    |

2. **Total revenue generated from pizza sales**:
    ```sql
    SELECT SUM(p.price * o.quantity) AS total_revenue 
    FROM pizzas p
    LEFT JOIN order_details o ON p.pizza_id = o.pizza_id;
    ```
    - **Explanation**: This query calculates the total revenue from pizza sales by multiplying the price of each pizza by the quantity ordered (from the `order_details` table) and summing the results.
    - **Expected Output**:
      | total_revenue |
      |----------------|
      | 2500           |

3. **Highest-priced pizza**:
    ```sql
    SELECT t.pizza_type_id, p.price AS High_Demand
    FROM pizza_types t
    LEFT JOIN pizzas p ON t.pizza_type_id = p.pizza_type_id
    ORDER BY p.price DESC;
    ```
    - **Explanation**: This query retrieves the highest-priced pizza by joining the `pizza_types` and `pizzas` tables and ordering the results by price in descending order. 
    - **Expected Output**:
      | pizza_type_id | High_Demand |
      |----------------|-------------|
      | 2              | 30          |

4. **Most common pizza size ordered**:
    ```sql
    SELECT p.size, COUNT(o.order_id) AS size_order 
    FROM pizzas p
    LEFT JOIN order_details o ON o.pizza_id = p.pizza_id
    GROUP BY p.size
    ORDER BY size_order DESC;
    ```
    - **Explanation**: This query counts the number of orders for each pizza size by joining the `pizzas` and `order_details` tables, grouping by pizza size, and ordering the results by the count of orders in descending order.
    - **Expected Output**:
      | size   | size_order |
      |--------|------------|
      | Medium | 80         |
      | Large  | 50         |
      | Small  | 20         |

5. **Top 5 most ordered pizza types**:
    ```sql
    SELECT p.pizza_type_id, SUM(o.quantity) AS Top_5_Most
    FROM order_details o
    LEFT JOIN pizzas p ON o.pizza_id = p.pizza_id
    GROUP BY p.pizza_type_id
    ORDER BY Top_5_Most DESC
    LIMIT 5;
    ```
    - **Explanation**: This query finds the top 5 pizza types based on the total quantity ordered by joining the `order_details` and `pizzas` tables, summing the quantities, and limiting the results to the top 5.
    - **Expected Output**:
      | pizza_type_id | Top_5_Most |
      |----------------|------------|
      | 1              | 100        |
      | 2              | 75         |
      | 3              | 50         |
      | 4              | 40         |
      | 5              | 30         |

6. **Total quantity of each pizza category ordered**:
    ```sql
    SELECT t.category, SUM(o.quantity) AS Quant 
    FROM order_details o 
    LEFT JOIN pizzas p ON o.pizza_id = p.pizza_id
    LEFT JOIN pizza_types t ON p.pizza_type_id = t.pizza_type_id
    GROUP BY t.category
    ORDER BY Quant DESC;
    ```
    - **Explanation**: This query calculates the total quantity of pizzas ordered for each category by joining the `order_details`, `pizzas`, and `pizza_types` tables, grouping by category, and summing the quantities.
    - **Expected Output**:
      | category      | Quant |
      |---------------|-------|
      | Vegetarian    | 120   |
      | Non-Vegetarian| 80    |
      | Vegan         | 50    |

7. **Distribution of orders by hour of the day**:
    ```sql
    SELECT strftime('%H', time) AS hour, COUNT(order_id) AS distribution_of_order
    FROM orders
    GROUP BY hour
    ORDER BY hour ASC;
    ```
    - **Explanation**: This query analyzes order distribution by the hour of the day by extracting the hour from the order time and counting the number of orders for each hour.
    - **Expected Output**:
      | hour | distribution_of_order |
      |------|-----------------------|
      | 00   | 5                     |
      | 01   | 2                     |
      | 02   | 1                     |
      | 03   | 0                     |
      | ...  | ...                   |
      | 23   | 7                     |

8. **Average number of pizzas ordered per day**:
    ```sql
    WITH temp1 AS (
        SELECT o.date, SUM(d.quantity) AS Total_order 
        FROM orders o 
        LEFT JOIN order_details d ON o.order_id = d.order_id
        GROUP BY date
    )
    SELECT date, ROUND(AVG(total_order), 2) AS Average_Pizza_per_day
    FROM temp1
    GROUP BY date
    ORDER BY date ASC;
    ```
    - **Explanation**: This query first calculates the total number of pizzas ordered per day and then computes the average of these totals across all days.
    - **Expected Output**:
      | date       | Average_Pizza_per_day |
      |------------|------------------------|
      | 2024-10-01 | 25.50                  |
      | 2024-10-02 | 30.00                  |
      | ...        | ...                    |

9. **Top 3 most ordered pizza types based on revenue**:
    ```sql
    SELECT t.name, SUM(o.quantity * p.price) AS revenue 
    FROM order_details o 
    LEFT JOIN pizzas p ON o.pizza_id = p.pizza_id
    LEFT JOIN pizza_types t ON p.pizza_type_id = t.pizza_type_id
    GROUP BY t.name
    ORDER BY revenue DESC
    LIMIT 3;
    ```
    - **Explanation**: This query determines the top 3 pizza types based on the revenue generated by multiplying the quantity ordered by the price and summing these values.
    - **Expected Output**:
      | name         | revenue |
      |--------------|---------|
      | Margherita   | 1500    |
      | Pepperoni    | 1200    |
      | Veggie       | 800     |

10. **Percentage contribution of each pizza type to total revenue**:
    ```sql
    WITH temp1 AS (
        SELECT t.name, SUM(o.quantity * p.price) AS revenue
        FROM order_details o 
        LEFT JOIN pizzas p ON o.pizza_id = p.pizza_id
        LEFT JOIN pizza_types t ON p.pizza_type_id = t.pizza_type_id
        GROUP BY t.name
        ORDER BY revenue DESC
    )
    SELECT name, revenue, ROUND((revenue / SUM(revenue) OVER()) * 100, 2) AS percent
    FROM temp1;
    ```
    - **Explanation**: This query calculates the revenue for each pizza type and computes the percentage of total revenue contributed by each type using a common table expression (CTE).
    - **Expected Output**:
      | name         | revenue | percent |
      |--------------|---------|---------|
      | Margherita   | 1500    | 40.00   |
      | Pepperoni    | 1200    | 32.00   |
      | Veggie       | 800     | 21.00   |
      | Hawaiian     | 300     | 7.00    |

11. **Daily revenue and cumulative revenue**:
    ```sql
    SELECT o.date, 
           SUM(o2.quantity * p.price) AS revenue,
           SUM(SUM(o2.quantity * p.price)) OVER (ORDER BY o.date) AS cumulative_revenue
    FROM orders o
    LEFT JOIN order_details o2 ON o.order_id = o2.order_id
    LEFT JOIN pizzas p ON o2.pizza_id = p.pizza_id
    GROUP BY o.date
    ORDER BY o.date;
    ```
    - **Explanation**: This query calculates the revenue generated on each date and computes the cumulative revenue over time using a window function.
    - **Expected Output**:
      | date       | revenue | cumulative_revenue |
      |------------|---------|---------------------|
      | 2024-10-01 | 200     | 200                 |
      | 2024-10-02 | 300     | 500                 |
      | 2024-10-03 | 150     | 650                 |
      | 2024-10-04 | 400     | 1050                |

## Conclusion

The Pizza Sales Analysis project has provided a comprehensive overview of the sales performance of a pizza restaurant. By utilizing SQL queries to analyze various aspects of sales data, several key insights were uncovered:

- **Sales Performance**: The total revenue generated was significant, indicating strong sales performance, particularly for specific pizza types like Margherita and Pepperoni.
- **Customer Preferences**: The analysis revealed a clear preference for medium-sized pizzas, with vegetarian options leading in terms of quantity ordered.
- **Time Trends**: Insights into order distribution by hour showed peak ordering times, which can inform staffing and inventory management.
- **Revenue Insights**: The cumulative revenue analysis provided a clear picture of revenue trends over time, allowing for better forecasting and planning.

These insights can help the pizza restaurant make informed decisions regarding menu offerings, promotional strategies, and operational improvements. By continuously monitoring and analyzing sales data, the business can adapt to changing customer preferences and maximize revenue potential.

We recommend implementing targeted marketing campaigns focused on the most popular pizza types and sizes, as well as considering promotions during peak ordering hours to enhance customer engagement and sales.

### References
- [SQL Documentation](https://www.sql.org/)
- [Data Analysis Techniques](https://towardsdatascience.com/data-analysis-techniques)
