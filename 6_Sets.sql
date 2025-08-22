/* ==============================================================================
   SQL SET Operations
-------------------------------------------------------------------------------
   SQL set operations enable you to combine results from multiple queries
   into a single result set. This script demonstrates the rules and usage of
   set operations, including UNION, UNION ALL, EXCEPT, and INTERSECT.
   
   Table of Contents:
     1. SQL Operation Rules
     2. UNION
     3. UNION ALL
     4. EXCEPT
     5. INTERSECT
=================================================================================
*/

/* ==============================================================================
   RULES OF SET OPERATIONS
===============================================================================*/

-- Data Types: The data types of columns in each query should match.
-- Column Order: The order of the columns in each query must be the same.
-- Column Aliases: The column names in the result set are determined by the column names specified in the first SELECT statement.
-- Correct Columns: Ensure that the correct columns are used to maintain data consistency.


/* ==============================================================================
   SETS: UNION, UNION ALL, EXCEPT, INTERSECT
===============================================================================*/

-- TASK 1: Combine the data from Employees and Customers into one table using UNION 
select firstname, lastname, 'employee' as profile  
from sales.employees

union

select firstname, lastname, 'customer' as profile
from sales.customers


-- TASK 2: Combine the data from Employees and Customers into one table, including duplicates, using UNION ALL 
select firstname, lastname, 'employee' as profile  
from sales.employees

union all

select firstname, lastname, 'customer' as profile
from sales.customers

-- TASK 3: Find employees who are NOT customers using EXCEPT 
select firstname, lastname
from sales.employees

except

select firstname, lastname
from sales.customers

-- TASK 4: Find employees who are also customers using INTERSECT 
select firstname, lastname
from sales.employees

intersect

select firstname, lastname
from sales.customers


-- TASK 5: Combine order data from Orders and OrdersArchive into one report without duplicates 
select
    'Orders' as SourceTable,
    OrderID,
    ProductID,
    CustomerID,
    SalesPersonID,
    OrderDate,
    ShipDate,
    OrderStatus,
    ShipAddress,
    BillAddress,
    Quantity,
    Sales,
    CreationTime
from Sales.Orders

union

select
    'OrdersArchive' as SourceTable,
    OrderID,
    ProductID,
    CustomerID,
    SalesPersonID,
    OrderDate,
    ShipDate,
    OrderStatus,
    ShipAddress,
    BillAddress,
    Quantity,
    Sales,
    CreationTime
from Sales.OrdersArchive
order by OrderID;
