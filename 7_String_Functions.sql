/* ============================================================================== 
   SQL String Functions
-------------------------------------------------------------------------------
   This document provides an overview of SQL string functions, which allow 
   manipulation, transformation, and extraction of text data efficiently.

   Table of Contents:
     1. Manipulations
        - CONCAT
        - LOWER
        - UPPER
	- TRIM
	- REPLACE
     2. Calculation
        - LEN
     3. Substring Extraction
        - LEFT
        - RIGHT
        - SUBSTRING
=================================================================================
*/


/* ============================================================================== 
   CONCAT() - String Concatenation
=============================================================================== */

-- Concatenate first name and country into one column
select concat(firstname, ' ', country) 
from sales.customers;


/* ============================================================================== 
   LOWER() & UPPER() - Case Transformation
=============================================================================== */

-- Convert the first name to lowercase
select lower(firstname)
from sales.customers;

-- Convert the first name to uppercase
select upper(firstname)
from sales.customers;


	
/* ============================================================================== 
   TRIM() - Remove White Spaces
=============================================================================== */

-- Find customers whose first name contains leading or trailing spaces
SELECT
  id,
  first_name
FROM
  customers
WHERE
  first_name != TRIM(first_name);


/* ============================================================================== 
   REPLACE() - Replace or Remove old value with new one
=============================================================================== */

-- Remove dashes (-) from a phone number
select '123-456-7890' as phone,
replace('123-456-7890', '-', '') as clean_phone;


/* ============================================================================== 
   LEN() - String Length & Trimming
=============================================================================== */

-- Calculate the length of each customer's first name
select firstname,length(firstname) as length
from sales.customers;


/* ============================================================================== 
   LEFT() & RIGHT() - Substring Extraction
=============================================================================== */

-- Retrieve the first two characters of each first name
select firstname, left(trim(firstname),2) as first_2_chars
from sales.customers;

-- Retrieve the last two characters of each first name
select firstname, right(trim(firstname),2) as last_2_chars
from sales.customers;


/* ============================================================================== 
   SUBSTRING() - Extracting Substrings
=============================================================================== */

-- Retrieve a list of customers' first names after removing the first character
select firstname, substring(trim(firstname), 2, length(firstname)) as trimmed_name
from sales.customers;

/* ==============================================================================
   NESTING FUNCTIONS
===============================================================================*/

-- Nesting
select firstname, upper(lower(firstname)) as nesting
from sales.customers;


