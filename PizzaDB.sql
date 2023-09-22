select * from pizza_sales

-- Total Revenue
select SUM(total_price) AS Total_Revenue from pizza_sales


-- Average Order Value
SELECT (SUM(total_price) / COUNT(DISTINCT order_id)) AS Avg_Order_Value FROM pizza_sales


-- Total Pizza's Sold
SELECT SUM(quantity) AS Total_Pizza_Sold from pizza_sales


-- Total Orders
SELECT COUNT(DISTINCT order_id) AS Total_orders from pizza_sales


-- Average Pizzas Per Order
SELECT CAST(CAST(SUM(quantity) AS DECIMAL(10,2)) / CAST(COUNT(DISTINCT order_id) AS DECIMAL(10,2)) AS DECIMAL(10,2)) AS Avg_Pizzas_Per_Order FROM pizza_sales


-- Hourly Trend for Total Pizzas Sold
SELECT DATEPART(Hour, order_time) as order_hours, SUM(quantity) as total_pizzas_sold 
FROM pizza_sales 
group by DATEPART(Hour, order_time)
order by DATEPART(Hour, order_time)


-- Weekly Trend for Total Orders
SELECT 
    DATEPART(ISO_WEEK, order_date) as WeekNumber,
    YEAR(order_date) AS Year,
    COUNT(DISTINCT order_id) AS Total_orders
FROM
    pizza_sales
GROUP BY
    DATEPART(ISO_WEEK, order_date),
    YEAR(order_date)
ORDER BY
    Year, WeekNumber;


-- % of Sales by Pizza Category
SELECT pizza_category, sum(total_price) as Total_Sales, sum(total_price) * 100 /
(SELECT sum(total_price) from pizza_sales WHERE MONTH(order_date) = 1) AS PCT
from pizza_sales
WHERE MONTH(order_date) = 1
GROUP BY pizza_category


-- % of Sales by Pizza Size
SELECT pizza_size, CAST(sum(total_price) AS DECIMAL(10,2)) as Total_Sales, CAST(sum(total_price) * 100 / 
(SELECT sum(total_price) from pizza_sales WHERE DATEPART(quarter, order_date) = 1) AS DECIMAL(10,2)) AS PCT
from pizza_sales
WHERE DATEPART(quarter, order_date) = 1
GROUP BY pizza_size
ORDER BY PCT DESC

-- Top 5 Pizzas by Revenue
SELECT Top 5 pizza_name, SUM(total_price) AS Total_Revenue FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Revenue DESC


-- Bottom 5 Pizza by Revenue
SELECT Top 5 pizza_name, SUM(total_price) AS Total_Revenue FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Revenue ASC


-- Top 5 Pizzas by Quantity
SELECT Top 5 pizza_name, SUM(quantity) AS Total_Quantity FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Quantity DESC


-- Bottom 5 Pizzas by Quantity
SELECT Top 5 pizza_name, SUM(quantity) AS Total_Quantity FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Quantity ASC


-- Top 5 Pizzas by Total Orders
SELECT Top 5 pizza_name, COUNT(DISTINCT order_id) AS Total_orders FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_orders DESC


-- Bottom 5 Pizzas by Total Orders
SELECT Top 5 pizza_name, COUNT(DISTINCT order_id) AS Total_orders FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_orders ASC


-- Total Pizzas Sold by Pizza Category
SELECT pizza_category, SUM(quantity) as Total_Quantity_Sold
FROM pizza_sales
WHERE MONTH(order_date) = 2
GROUP BY pizza_category
ORDER BY Total_Quantity_Sold DESC