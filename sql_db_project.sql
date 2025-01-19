CREATE schema retail_salesl;

-- create table--
use retail_sales;
drop table if exists retail;
create table retail(
   transactions_id	int primary key,
   sale_date	date,
   sale_time	time,
   customer_id	int,
   gender	varchar(10),
   age	int,
   category	varchar(50),
   quantiy	int,
   price_per_unit	float,
   cogs	float,
   total_sale float
);

-- Data Cleaning -- 
select * from retail;
select count(*) from retail;
select * from retail
where transactions_id is null
      or sale_date is null
      or sale_time is null
      or customer_id is null
      or gender is null
      or age is null
      or category is null
      or quantiy is null
	  or price_per_unit is null
      or cogs is null
      or total_sale is null;
      
-- Data exploration --
-- How many sales we have --
select count(*) as total_sale from retail;

-- How many unique customers we have --
select count(distinct customer_id) as total_sale from retail;

-- How many unique category we have --
select count(distinct category) as total_sale from retail;

-- Data analysis --
 
-- 01. Write a SQl query to retrive all columns for sales made on 2022-11-05--
   select * from retail 
   where sale_date = '2022-11-05';

-- 02. write a SQl query to retrive all transaction where the category is 'clothing' and the quantity is more than 3 in the month of Nov-2022--
  select * from retail 
  where category = 'Clothing' 
  and DATE_FORMAT(sale_date, '%Y-%m') = '2022-11'
  and quantiy>=3;

-- 03. Write a SQL query to calculate the total sales (total_sale) for each category.
   select category, 
   sum(total_sale) as net_sale, 
   count(*) as total_orders 
   from retail group by 1 ;
   
-- 04. Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
   select round(avg(age)) as average_age 
   from retail where category='Beauty';
   
-- 05. Write a SQL query to find all transaction where the total_sale greater than 1000
   select * from retail
   where total_sale>1000;
   
-- 06. Write a SQL query to find the total number of transaction (transaction_id) made by each gender in each category.
   select category, gender, count(*) as total_tran from retail
   group by category, gender
   order by 1; 
   
-- 07. Write a SQL query to calculate the average sale for each month. Find out best selling month in each year.
   select extract(year from sale_date) as year, 
          extract(month from sale_date) as month, 
          avg(total_sale) as Average_sale,
          rank() over(partition by extract(year from sale_date) order by avg(total_sale) desc) as ranking
          from retail
          group by 1,2;
          
-- 08. Write a SQL query to find top 5 customers based on highest total sales.
   select customer_id, sum(total_sale) as Total_sales
   from retail group by 1
   order by 2 desc
   limit 5;
   
