/* ==============================================================================
   SQL CASE Statement
-------------------------------------------------------------------------------
   This script demonstrates various use cases of the SQL CASE statement, including
   data categorization, mapping, quick form syntax, handling nulls, and conditional 
   aggregation.
   
   Table of Contents:
     1. Categorize Data
     2. Mapping
     3. Quick Form of Case Statement
     4. Handling Nulls
     5. Conditional Aggregation
=================================================================================
*/

/* ==============================================================================
   USE CASE: CATEGORIZE DATA
===============================================================================*/

/* TASK 1: 
   Create a report showing total sales for each category:
	   - High: Sales over 50
	   - Medium: Sales between 20 and 50
	   - Low: Sales 20 or less
   The results are sorted from highest to lowest total sales.
*/
select category, sum(sales) as TotalSales 
from (
		select orderid, sales,
		case 
			when sales > 50 then 'High'
			when sales between 20 and 50 then 'Medium'
			when sales <=20 then 'Low'
		end as category
		from sales.orders
	) as t

group by category
order by TotalSales desc;




/* ==============================================================================
   USE CASE: MAPPING
===============================================================================*/

-- TASK 2: Retrieve customer details with abbreviated country codes 
select customerid, firstname, lastname, 
	case
		when country='USA' then 'US'
		when country='Germany' then 'DE'
		else 'na'
	end as country_code
from sales.customers;



/* ==============================================================================
   QUICK FORM SYNTAX
===============================================================================*/

-- TASK 3: Retrieve customer details with abbreviated country codes using quick form 
select customerid, firstname, lastname, 
	case country
		when 'USA' then 'US'
		when 'Germany' then 'DE'
		else 'na'
	end as country_code
from sales.customers;




/* ==============================================================================
   CONDITIONAL AGGREGATION
===============================================================================*/

-- TASK 4: Count orders per customer with sales > 30
select 
    customerid,
    lastname,
    firstname,
    count(case when sales > 30 then 1 end) as orders_above_30
from sales.orders
join sales.customers using (customerid)
group by customerid, lastname, firstname
order by orders_above_30 desc;
