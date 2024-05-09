
select * from forders

--updating and adding one more column related to pricing of the product.

alter table Forders
add price float
 
 update forders
 set price= sales/quantity
 

select * from forders


--Collaborated with the Web Development team to identify areas of improvement through customer data,using SQL to help improve the profitability (profit ratio)of the software product by 22% year on year basis.

--customer segmentation on basis of state,segment,ship_mode,category,sales,quantity

select customer_name,order_date,ship_mode,segment,state,category,sum(sales) as sales,sum(quantity) as quantity,sum(profit) as profit
from forders
group by customer_name,order_date,ship_mode,segment,state,category

--To find out the high value customer
 
 --calculating sales per customer

select sum(sales)as sales,customer_id
from forders
group by customer_id
order by sales desc

--calculating average order value per customer per category or segment
SELECT customer_id,category,segment, AVG(order_value) AS avg_order_value
FROM (
    SELECT customer_id ,order_id,category,segment, SUM(price * quantity) AS order_value
    FROM forders
    GROUP BY customer_id, order_id,category,segment
) AS order_totals
GROUP BY customer_id,category,segment
ORDER BY avg_order_value DESC;

--the most famous product category is furniture in consumer segment which has the highest average order value.

--To increase the profitability i.e the profit ratio or profit margin 

--calculating profit ratio and increasing the profit_ratio by 22%

with cte as 
(select sum(profit)as profit,sum(sales) as sales,customer_id
from forders
group by customer_id), bte as (select *,round((profit/sales)*100,2) as profit_ratio from cte )

select *,(profit_ratio*1.22) as increased_profit_ratio
from bte

-- So, if we increase the sales (i.e if we increase the pricing

--purchase frequency is count of orders per customer

SELECT customer_id, COUNT(order_id) AS purchase_frequency
FROM forders
GROUP BY customer_id
ORDER BY purchase_frequency DESC;

--product analysis (top performing/selling products)

SELECT product_name, SUM(sales) AS total_revenue
FROM forders
GROUP BY product_name
ORDER BY total_revenue DESC;

--Analysing spend

