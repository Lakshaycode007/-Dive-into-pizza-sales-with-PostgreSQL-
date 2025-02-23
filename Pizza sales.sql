-- creating Database
create database chipchop;
-- create a tabke and its structure
create table Pizzas(
	pizza_id serial Primary key,
	order_id int not null,
	pizza_name_id varchar(100) Not Null,
	quantity int,	
	order_date date,	
	order_time Time,	
	unit_price numeric(5,2),	
	total_price numeric(5,2),	
	pizza_size varchar(10),	
	pizza_category varchar(50),	
	pizza_ingredients text,	
	pizza_name varchar(300)	
);

-- importing Data from csv file into sql
copy Pizzas(
	pizza_id, order_id, pizza_name_id, quantity, order_date,
	order_time, unit_price,
	total_price, pizza_size,
	pizza_category, pizza_ingredients, pizza_name
)
from 'D:\Skill Nation\Excel\Pizza_Sales.csv'
DELIMITER','
CSV HEADER;

TRUNCATE TABLE pizzas;



--Total revenue 
select Sum(total_price) as Total_Revenue from pizzas;

--Average order value
select round(sum(total_price)/count(distinct order_id),2) As avg_order_value from pizzas;

-- Top 10 sold pizza 
select pizza_name, sum(quantity) as Pizza_sold from pizzas group by pizza_name order by pizza_sold desc limit 10;

--Bottom 10 sold pizza 
select pizza_name, sum(quantity) as Pizza_sold from pizzas group by pizza_name order by pizza_sold asc limit 10;


--Total order place
select count(distinct order_id) as orders_deliver from pizzas; 


--Average pizzas per order
select round(cast(sum(quantity) as decimal(10,2))/ cast(count(distinct order_id) as decimal(10,2)),2) as Avg_pizza_order from pizzas;

--Daily trend for total orders 
SELECT
    TO_CHAR(order_date, 'Day') AS day_name,
    COUNT(DISTINCT order_id) AS total_orders
FROM
    pizzas
WHERE
    EXTRACT(DOW FROM order_date) BETWEEN 0 AND 6 -- Filter for weekdays (sunday to saturday)
GROUP BY
    day_name;

--Percentage of sales according to pizza category
select 
	pizza_category,
	round(sum(total_price)*100 / (select sum(total_price) from pizzas),2) as percentage_sales
from Pizzas 
group by pizza_category
order by percentage_sales;


--Percentage of sales by pizza size
select 
	Pizza_size,
	round(sum(total_price)*100 / (select sum(total_price) from pizzas),2) as percentage_sales
from Pizzas 
group by pizza_size
order by percentage_sales;

SELECT * FROM pizzas;
--Total pizza sold by pizza category
select pizza_category, sum(quantity) as pizza_sold from pizzas group by pizza_category;