/* ==============================================================================
   SQL SELECT Query
-------------------------------------------------------------------------------
   This guide covers various SELECT query techniques used for retrieving, 
   filtering, sorting, and aggregating data efficiently.

   Table of Contents:
     1. SELECT ALL COLUMNS
     2. SELECT SPECIFIC COLUMNS
     3. WHERE CLAUSE
     4. ORDER BY
     5. GROUP BY
     6. HAVING
     7. DISTINCT
     8. TOP
     9. Combining Queries
=================================================================================
*/

/* ==============================================================================
   COMMENTS
=============================================================================== */

-- This is a single-line comment.

/* This
   is
   a multiple-line
   comment
*/



/* ==============================================================================
   SELECT ALL COLUMNS
=============================================================================== */

-- Retrieve All Customer Data
select * from customers;

-- Retrieve All Order Data
select * from orders;



/* ==============================================================================
   SELECT FEW COLUMNS
=============================================================================== */

-- Retrieve each customer's name, country, and score.
select first_name, country, score
from customers;



/* ==============================================================================
   WHERE
=============================================================================== */

-- Retrieve customers with a score not equal to 0
select * from customers
where score!=0;

-- Retrieve customers from Germany
select * from customers
where country='Germany';

-- Retrieve the name and country of customers from Germany
select first_name, country 
from customers
where country='Germany';



/* ==============================================================================
   ORDER BY
=============================================================================== */

-- Retrieve all customers and sort the results by the highest score first. 
select * 
from customers
order by score desc;


-- Retrieve all customers and sort the results by the lowest score first.
select *
from customers
order by score asc;

-- Retrieve all customers and sort the results by the country.
select *
from customers
order by country asc;

-- Retrieve all customers and sort the results by the country and then by the highest score.
select * 
from customers
order by country asc, score desc;

-- Retrieve the name, country, and score of customers whose score is not equal to 0 and sort the results by the highest score first.
select first_name, country, score
from customers
where score!=0
order by score desc;



/* ==============================================================================
   GROUP BY
=============================================================================== */

-- Find the total score for each country
select country, sum(score) as total_score
from customers
group by country;

-- Find the total score and total number of customers for each country
select country, sum(score) as total_score, count(*) as total_customers
from customers
group by country;



/* ==============================================================================
   HAVING
=============================================================================== */

-- Find the average score for each country and return only those countries with an average score greater than 430
select country, avg(score)
from customers
group by country
having avg(score)>430;

/* Find the average score for each country
   considering only customers with a score not equal to 0
   and return only those countries with an average score greater than 430 */
select country, avg(score)
from customers
where score!=0
group by country
having avg(score)>430;



/* ==============================================================================
   DISTINCT
=============================================================================== */

-- Return Unique list of all countries
select distinct country
from customers;



/* ==============================================================================
   LIMIT
=============================================================================== */

-- Retrieve only 3 Customers
select *
from customers
limit 3; 

-- Retrieve the Top 3 Customers with the Highest Scores
select *
from customers
order by score desc
limit 3;

-- Get the Two Most Recent Orders
select *
from orders
order by order_date desc
limit 2;



/* ==============================================================================
   All Together
=============================================================================== */

/* Calculate the average score for each country 
   considering only customers with a score not equal to 0
   and return only those countries with an average score greater than 430
   and sort the results by the highest average score first. */
select country, avg(score) as avg_score
from customers
where score!=0
group by country
having avg(score)>430
order by avg_score desc;


