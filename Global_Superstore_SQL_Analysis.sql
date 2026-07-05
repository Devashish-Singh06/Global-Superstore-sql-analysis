



-- ===================================
-- 01_Data_Exploration
-- ===================================

-- Total Orders

select count(*) as Total_Orders from orders;

-- Total Returned Orders

select count(*) as Total_Returned_orders from returns;

-- Total Regions

select count(distinct region) as Total_Regions from orders;

-- Total Customer

select count(distinct customer_id) as Total_Customer from orders;

-- Total Products

select count(distinct product_id) as Total_Products from orders;

-- Distinct Categories

select distinct category from orders;

-- Distinct Segment

select distinct segment from orders;

-- Distinct Ship Modes

select distinct ship_mode from orders;

-- Date Range

select Min(order_date) as First_order, Max(order_date) as Last_order from orders;




-- ===================================
-- 02_Sales_Analysis
-- ===================================

-- Total Sales

select round(Sum(sales)) as Total_Sales from orders;

-- Total Profit 

select round(Sum(profit)) as Total_Profit from orders;

-- Total Quantity Sold

select Sum(quantity) as Total_Quantity from orders;

-- Sales by Region

Select Region, round(Sum(sales)) as Total_sales from orders
Group By Region;

-- Profit by Region

Select Region, round(Sum(profit)) as Total_Profit from orders
Group By Region;

-- Sales by Category

Select Category, round(sum(sales)) as Total_Sales from orders
Group By Category;

-- Profit by Category

Select Category, round(sum(profit)) as Total_Profit from orders
Group By Category;

-- Sales by Segment 

Select Segment, round(sum(sales)) as Total_Sales from orders
Group By Segment;

-- Profit by Segment

Select Segment, round(sum(profit)) as Total_Profit from orders
Group By Segment;

-- Top 5 Cities by Sales

select * from 
(
select city, round(Sum(sales)) as Total_Sales from orders
Group By city 
Order By Total_Sales desc 
)
where rownum <= 5;

-- Top 5 cities by profit

select * from 
(
select city, round(sum(profit)) as Total_Profit from orders
Group By city
Order By Total_Profit desc
)
where rownum <= 5;

-- Average Order Value

select round(Sum(sales)/ count(distinct order_id),2) as Average_Order_Value from orders;




-- ===================================
-- 03_Customer_Analysis
-- ===================================


-- Customer Count by Segment

select Segment, count(distinct customer_id) as Total_Customers from orders
Group By segment;

-- Highest Sales Segment

select * from 
(
select Segment, round(sum(sales)) as Total_Sales from orders
Group By segment
Order By Total_Sales desc
)
where rownum <= 1;

-- Highest Profit Segment

select * from 
(
select Segment, round(sum(profit)) as Total_Profit from orders
Group By segment
Order By Total_Profit desc
)
where rownum <= 1;

-- Top 10 Customers by Sales

select * from 
(
select customer_id, customer_name, round(sum(sales)) as Total_Sales from orders
Group By customer_name, customer_id
order by Total_sales desc
)
where rownum <= 10;

-- Top 10 Customers by Profit

select * from 
(
select customer_id, customer_name, round(sum(profit)) as Total_Profit from orders
Group By customer_name, customer_id
order by Total_Profit desc
)
where rownum <= 10;

-- Average Sales per Customer

select round(sum(sales)/count(distinct customer_id),2) as Average_Sales_Per_Customer from orders;




-- ===================================
-- 04_Product_Analysis
-- ===================================

-- Product Count by Category

select Category, count(distinct product_id) as Total_Products from orders
Group By Category;

-- Product Count by Sub-Category

select Sub_Category, count(distinct product_id) as Total_Products from orders
Group By Sub_Category;

-- Highest Selling Category

select * from 
(
select Category, round(sum(sales)) as Total_Sales from orders
Group By Category
Order By Total_Sales desc
)
where rownum <= 1;

-- Highest Profit Category

select * from 
(
select Category, round(sum(profit)) as Total_Profit from orders
Group By Category
Order By Total_Profit desc
)
where rownum <= 1;

-- Top 10 Products by Sales

select * from 
(
select Product_id, Product_name, round(Sum(sales)) as Total_Sales from orders
Group By Product_name, Product_id
Order By Total_Sales desc
)
where rownum <= 10;

-- Top 10 Products by Profit

select * from 
(
select Product_id, Product_name, round(Sum(profit)) as Total_Profit from orders
Group By Product_name, Product_id
Order By Total_Profit desc
)
where rownum <= 10;

-- Average Sales per Product

select round(Sum(sales) / Count(distinct product_id)) as Average_Sales_Per_Product from orders;

-- Most Ordered Products

select * from
(
select Product_id, Product_name, count(product_id) as Order_Count from orders
Group By Product_id, Product_name
Order By Order_count desc
)
where rownum <= 1;

-- Least Profitable Products 

    select * from
    (
    select Product_id, Product_name, round(Sum(profit)) as Total_Profit from orders
    Group By Product_id, Product_name
    Order By Total_Profit asc
    )
    where rownum <= 10;

-- Category-wise Sales Contribution

select Category, round(sum(sales) / (select sum(sales) from orders)* 100, 2) as Sales_Contribution_Percentage from orders
Group By Category
Order By Sales_Contribution_Percentage desc;




-- ===================================
-- 05_Regional_Analysis
-- ===================================

-- Sales by Region

select Region, round(Sum(sales)) as Total_Sales from orders
Group By Region;

-- Profit by Region

select Region, round(Sum(profit)) as Total_Profit from orders
Group By Region;

-- Sales by State

select State_and_Province, round(Sum(sales)) as Total_Sales from orders
Group By State_and_Province;

-- Profit by State

select State_and_Province, round(Sum(profit)) as Total_Profit from orders
Group By State_and_Province;

-- Top 10 States by Sales

Select * from 
(
Select State_and_Province, round(sum(sales)) as Total_Sales from orders
Group By State_and_Province
Order By Total_Sales desc
)
where rownum <= 10;

-- Top 10 States by Profit

Select * from 
(
Select State_and_Province, round(sum(profit)) as Total_Profit from orders
Group By State_and_Province
Order By Total_Profit desc
)
where rownum <= 10;

-- Lowest 10 States by Profit

Select * from 
(
Select State_and_Province, round(sum(profit)) as Total_Profit from orders
Group By State_and_Province
Order By Total_Profit asc
)
where rownum <= 10;

-- Sales by City

select City, round(Sum(Sales)) as Total_Sales from orders
Group By City;

-- Highest Sales Region

Select * from
(
Select Region, round(Sum(sales)) as Total_Sales from orders
Group By Region
Order By Total_Sales desc
)
where rownum <= 1;

-- Regional Sales Contribution (%)

Select Region, round(Sum(sales)/(select sum(sales) from orders)*100,2) as Sales_Contribution_Percentage from orders
Group By Region;

-- Regions Contributing More Than 30% of Total Sales

Select Region, round(Sum(sales)/(select sum(sales) from orders)*100,2) as Sales_Contribution_Percentage from orders
Group By Region
Having round(Sum(sales)/(select sum(sales) from orders)*100,2) > 30;




-- ===================================
-- 06_Return_Analysis
-- ===================================

-- Total Returned Orders

Select count(order_id) as Total_Returned_orders from returns;
    
-- Return Rate (%)

Select round(Count(distinct r.order_id) / count(distinct o.order_id) * 100,2) as Return_Rate from orders o left outer join returns r 
on o.order_id = r.order_id;

-- Alternative Method

select round((select count(distinct order_id) from returns)/ (select count(distinct order_id) from orders)  * 100,2) as Return_Rate from dual;

-- Returned Sales 

Select round(Sum(o.sales)) as Total_Sales_Lost from orders o inner join returns r
on o.order_id = r.order_id;

-- Returned Orders by Region

Select O.Region, Count(distinct R.order_id) as Total_Returned_Orders from orders O inner join returns R
on O.order_id = R.order_id
Group By O.Region;

-- Returned Sales by Region

Select O.Region, round(sum(O.sales)) as Total_Sales_Lost from orders O inner join returns R
on O.order_id = R.order_id
Group By O.Region;

-- Return Rate by Region (%)

Select O.Region, round(count(distinct R.order_id)/count(distinct O.order_id)*100,2) as Return_Rate from orders O left outer join returns R
on O.order_id = R.order_id
Group By O.region;

-- Top 5 Returned Products

select * from 
(
Select O.Product_name, Count(distinct R.order_id) as Return_Count from orders O inner join Returns R
on O.order_id = R.order_id
group by O.product_name
Order by Return_Count desc
)
where rownum <=5;

-- Top 5 Returned Customers

select * from 
(
Select O.Customer_name, Count(distinct R.order_id) as Return_Count from orders O inner join Returns R
on O.order_id = R.order_id
group by O.Customer_id, O.Customer_name
Order by Return_Count desc
)
where rownum <=5;

-- Regional Manager with Highest Returned Sales

select * from
(
Select P.Regional_Manager, Round(Sum(O.sales)) as Returned_Sales from orders O inner join Returns R
on O.order_id = R.order_id inner join People P on O.region = P.region
Group By P.Regional_Manager
Order By Returned_Sales desc
)
where rownum <= 1;

-- Regional Manager Return Summary

Select P.Regional_Manager, Count(distinct R.order_id) as Returned_Orders, Round(Sum(O.sales)) as Returned_Sales from orders O inner join Returns R
on O.order_id = R.order_id inner join People P on O.region = P.region
Group By P.Regional_Manager
Order By Returned_Sales desc;




-- ===================================
-- 07_Advanced_SQL_Concepts
-- ===================================

--------------------------------------------
PART A : CHARACTER MANIPULATION FUNCTIONS
--------------------------------------------

-- Customer Names in Uppercase

select Customer_Name, upper(Customer_Name) as Customer_Name_Uppercase from orders;

-- First 12 Characters of Product Name

Select Product_Name, Substr(Product_Name, 1, 12) as Short_Product_Name from orders;

-- Product Name Length

select Product_Name, Length(Product_Name) as Length_of_Product_Name from orders;

--------------------------------------------
PART B – CASE Statement
--------------------------------------------

-- Sales Category

Select Round(sales) as Sales,
Case 
When Sales >= 1000 Then 'High Sales'
When Sales >= 500 and Sales < 1000 Then 'Medium Sales'
else 'Low Sales'
End as Sales_Category
from orders;

-- Profit Category

Select Round(Profit) as Profit,
Case 
When Profit > 0 Then 'Profit'
When Profit = 0 Then 'Break-Even'
else 'Loss'
End as Profit_Category
from orders;

-- Discount Status

Select Order_id, Discount,
Case 
When Discount > 0 Then 'Discount Applied'
else 'No Discount'
End as Discount_Status
from orders;

--------------------------------------------
PART C – Advanced Subqueries
--------------------------------------------

-- Customers Spending Above Average

Select Customer_id, Customer_name, Round(Sum(Sales)) as Total_Sales from orders
Group By Customer_id, Customer_name
having Sum(Sales) > 
(
select round(Avg(Total_Sales)) as Average_Customer_Sales from 
(
Select Customer_id, Customer_name, Sum(Sales) as Total_Sales from orders
Group By Customer_id, Customer_name
)
);

-- Products Whose Sales Are Above Average Product Sales

Select Product_id, Product_Name, round(sum(sales)) as Total_Sales from orders
Group By Product_id, Product_Name
Having sum(sales) > 
(
Select Avg(Total_Sales) from 
( 
Select Product_id, Product_Name, sum(sales) as Total_Sales from orders
Group By Product_id, Product_Name
)
);

-- Products That Were Never Returned

Select distinct Product_id, Product_name from orders 
Where Product_id not in (Select O.product_id from Returns R inner join Orders O 
on R.order_id = O.order_id);

-- Customers Who Never Returned an Order

Select distinct Customer_id, Customer_name from orders 
Where Customer_id not in (Select O.Customer_id from Returns R inner join Orders O 
on R.order_id = O.order_id);

-- Regions Whose Sales Are Above the Average Regional Sales

Select Region, round(sum(sales)) as Total_Sales from orders
Group By Region
Having sum(sales) > 
(
Select Avg(Total_Sales) from 
( 
Select Region, sum(sales) as Total_Sales from orders
Group By Region
)
);

--------------------------------------------
PART D – CTE
--------------------------------------------

-- Top 5 Customers by Sales using a CTE

With Customer_Sales as 
(
select customer_id, customer_name, round(sum(sales)) as Total_Sales from orders
Group By customer_name, customer_id
order by Total_sales desc
)
Select * from Customer_Sales where rownum <=5;

-- Category-wise Sales using a CTE

With Category_Wise_Sales as
(
Select Category, round(sum(sales)) as  Total_Sales from orders
Group By Category
)
Select * from Category_Wise_Sales;

--------------------------------------------
PART E : WINDOW FUNCTIONS
--------------------------------------------

-- Rank Customers by Total Sales (RANK())

Select Customer_id, Customer_Name, round(Sum(Sales)) as Total_Sales, Rank() over(order by round(Sum(Sales)) desc) as Sales_Rank from orders
Group By Customer_id, Customer_Name;

-- Row Number for Customers (ROW_NUMBER())

Select Row_Number() over(order by round(Sum(Sales)) desc) as Row_Number, Customer_id, Customer_Name, round(Sum(Sales)) as Total_Sales from orders
Group By Customer_id, Customer_Name;

-- Rank Products by Profit (DENSE_RANK())

Select Product_id, Product_Name, round(sum(profit)) as Total_Profit, Dense_rank() Over(order by round(sum(profit)) desc) as Profit_rank from orders
Group By Product_id, Product_Name;

--------------------------------------------
PART F – Views
--------------------------------------------

-- Create a Sales Summary View

Create View Sales_Summary_View as 
select Category, Round(sum(sales)) as Total_Sales, Round(sum(profit)) as Total_Profit from orders
Group By Category;

select * from Sales_Summary_View;

-- Create a Customer Summary View

Create View Customer_Summary_View as 
select Customer_id, Customer_Name, Round(sum(sales)) as Total_Sales, Round(sum(profit)) as Total_Profit from orders
Group By Customer_id, Customer_Name;

select * from Customer_Summary_View;

--------------------------------------------
PART G - Indexes
--------------------------------------------

-- Create an Index on ORDER_ID

Create index idx_order_id
on orders(order_id);

-- Create an Index on CUSTOMER_ID

Create index idx_customer_id
on orders(Customer_id);
