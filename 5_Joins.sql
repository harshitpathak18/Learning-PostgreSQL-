/* ==============================================================================
   SQL Joins 
-------------------------------------------------------------------------------
   This document provides an overview of SQL joins, which allow combining data
   from multiple tables to retrieve meaningful insights.

   Table of Contents:
   
     1. Basic Joins
        - INNER JOIN
        - LEFT JOIN
        - RIGHT JOIN
        - FULL JOIN
		
     2. Advanced Joins
        - LEFT ANTI JOIN
        - RIGHT ANTI JOIN
        - ALTERNATIVE INNER JOIN
        - FULL ANTI JOIN
        - CROSS JOIN
     
	 3. Multiple Table Joins (4 Tables)
=================================================================================
*/


/* ============================================================================== 
   BASIC JOINS 
=============================================================================== */

-- No Join
/* Retrieve all data from customers and orders as separate results */
select * from customers;
select * from orders;

-- INNER JOIN
/* Get all customers along with their orders, 
   but only for customers who have placed an order */
select 
	c.id,
    c.first_name,
    o.order_id,
    o.sales 
from customers as c
inner join orders as o
on c.id=o.customer_id;

-- LEFT JOIN
/* Get all customers along with their orders, 
   including those without orders */
select 
	c.id,
    c.first_name,
    o.order_id,
    o.sales
from customers as c
left join orders as o
on c.id=o.customer_id;

-- RIGHT JOIN
/* Get all customers along with their orders, 
   including orders without matching customers */
select * 
from customers as c
right join orders as o
on o.customer_id=c.id;


-- FULL JOIN
/* Get all customers and all orders, even if there’s no match */
select *
from customers as c
full join orders as o
on o.customer_id=c.id;


/* ============================================================================== 
   ADVANCED JOINS
=============================================================================== */

-- LEFT ANTI JOIN
/* Get all customers who haven't placed any order */
select c.id, c.first_name
from customers as c
left join orders as o
on c.id=o.customer_id
where order_id is null;


-- RIGHT ANTI JOIN
/* Get all orders without matching customers */
select *
from customers as c
right join orders as o
on c.id=o.customer_id
where c.id is null;

-- FULL ANTI JOIN
/* Find customers without orders and orders without customers */
select
    c.id,
    c.first_name,
    o.order_id,
    o.customer_id,
    o.sales
from customers as c 
full join orders as o 
on c.id = o.customer_id
where o.customer_id is null or c.id is null;

-- CROSS JOIN
/* Generate all possible combinations of customers and orders */
select *
from customers
cross join orders;

/* ============================================================================== 
   MULTIPLE TABLE JOINS (4 Tables)
=============================================================================== */

/* Task: Using SalesDB, Retrieve a list of all orders, along with the related customer, product, 
   and employee details. For each order, display:
   - Order ID
   - Customer's name
   - Product name
   - Product price
   - Salesperson's name */

select 
	o.orderid as order_id,
	c.firstname as customer_name,
	p.product as product_name,
	p.price as product_price,
	e.firstname as sales_person
from sales.customers as c
join sales.orders as o
on o.customerid=c.customerid
join sales.employees as e
on e.employeeid=o.salespersonid
join sales.products as p
on p.productid=o.productid
