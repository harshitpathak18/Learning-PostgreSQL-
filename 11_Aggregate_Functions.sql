/* ============================================================================== 
   SQL Aggregate Functions
-------------------------------------------------------------------------------
   This document provides an overview of SQL aggregate functions, which allow 
   performing calculations on multiple rows of data to generate summary results.

   Table of Contents:
     1. Basic Aggregate Functions
        - COUNT
        - SUM
        - AVG
        - MAX
        - MIN
     2. Grouped Aggregations
        - GROUP BY
=================================================================================*/


/* ============================================================================== 
   BASIC AGGREGATE FUNCTIONS
=============================================================================== */

-- Find the total number of customers
select count(*) as total_customers
from sales.customers;

-- Find the total sales of all orders
select sum(sales) as total_sales
from sales.orders

-- Find the average sales of all orders
select avg(sales)
from sales.orders;

-- Find the highest score among customers
select max(score)
from sales.customers;

-- Find the lowest score among customers
select min(score)
from sales.customers;


/* ============================================================================== 
   GROUPED AGGREGATIONS - GROUP BY
=============================================================================== */

-- Find the number of orders, total sales, average sales, highest sales, and lowest sales per customer
select  customerid,
		count(*) as total_orders, 
		sum(sales) as total_sales, 
		round(avg(sales)) as average_sales,
		max(sales) as highest_sales,
		min(sales) as lowest_sales

from sales.orders 
group by customerid
order by customerid;
