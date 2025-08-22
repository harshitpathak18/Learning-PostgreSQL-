/* ==============================================================================
   PostgreSQL Date & Time Functions
-------------------------------------------------------------------------------
   This script demonstrates various date and time functions in PostgreSQL.
   It covers functions such as CURRENT_DATE, CURRENT_TIMESTAMP, DATE_TRUNC, 
   EXTRACT, DATE_PART, AGE, TO_CHAR, CAST, INTERVAL arithmetic, and validation.
   
   Table of Contents:
     1. CURRENT_DATE | Date Values
     2. Date Part Extractions (DATE_TRUNC, EXTRACT, DATE_PART)
     3. DATE_TRUNC with Aggregation
     4. End of Month
     5. Date Parts (Yearly / Monthly / Friendly Names / Filtering)
     6. TO_CHAR (Formatting)
     7. CAST (Data Type Conversion)
     8. Date Arithmetic (INTERVAL, AGE, differences)
     9. Date Validation
=============================================================================== */


/* ==============================================================================
   1. CURRENT_DATE | DATE VALUES
===============================================================================*/

-- TASK 1: Display OrderID, CreationTime, a hard-coded date, and the current system date.
SELECT orderid, 
       creationtime::date AS creation_date,
       DATE '2025-08-21'  AS hardcoded_date, 
       CURRENT_DATE       AS system_date,
       CURRENT_TIMESTAMP  AS system_timestamp
FROM sales.orders;


/* ==============================================================================
   2. DATE PART EXTRACTIONS (DATE_TRUNC, EXTRACT, DATE_PART)
===============================================================================*/

-- TASK 2: Extract various parts of CreationTime
SELECT creationtime,
       DATE_TRUNC('year', creationtime)  AS year_start,
       DATE_TRUNC('month', creationtime) AS month_start,
       DATE_TRUNC('day', creationtime)   AS day_start,

       EXTRACT(year  FROM creationtime)  AS creation_year,
       EXTRACT(month FROM creationtime)  AS creation_month,
       EXTRACT(day   FROM creationtime)  AS creation_day,
       EXTRACT(hour  FROM creationtime)  AS creation_hour,

       DATE_PART('dow', creationtime)    AS day_of_week  -- 0=Sunday
FROM sales.orders;


/* ==============================================================================
   3. DATE_TRUNC() with Aggregation
===============================================================================*/

-- TASK 3: Aggregate orders by year
SELECT DATE_TRUNC('year', creationtime)::date AS year_start,
       COUNT(*) AS order_count
FROM sales.orders
GROUP BY DATE_TRUNC('year', creationtime)
ORDER BY year_start;


/* ==============================================================================
   4. End of Month
===============================================================================*/

-- TASK 4: Display OrderID, CreationTime, and the end-of-month date
SELECT orderid,
       creationtime,
       (DATE_TRUNC('month', creationtime) + INTERVAL '1 month - 1 day')::date AS end_of_month
FROM sales.orders;


/* ==============================================================================
   5. DATE PARTS | USE CASES
===============================================================================*/

-- TASK 5: Orders per year
SELECT EXTRACT(year FROM creationtime) AS year,
       COUNT(*) AS order_count
FROM sales.orders
GROUP BY year
ORDER BY year;

-- TASK 6: Orders per month (numeric)
SELECT EXTRACT(year FROM creationtime)  AS year,
       EXTRACT(month FROM creationtime) AS month,
       COUNT(*) AS order_count
FROM sales.orders
GROUP BY year, month
ORDER BY year, month;

-- TASK 7: Orders per month (friendly month names)
SELECT TO_CHAR(creationtime, 'YYYY-Mon') AS year_month,
       COUNT(*) AS order_count
FROM sales.orders
GROUP BY year_month
ORDER BY MIN(creationtime);

-- TASK 8: Orders placed in February (any year)
SELECT *
FROM sales.orders
WHERE EXTRACT(month FROM creationtime) = 2;


/* ==============================================================================
   6. TO_CHAR (Formatting)
===============================================================================*/

-- TASK 9: Format CreationTime in various ways
SELECT creationtime,
       TO_CHAR(creationtime, 'YYYY-MM-DD') AS iso_date,
       TO_CHAR(creationtime, 'Mon DD, YYYY') AS pretty_date,
       TO_CHAR(creationtime, 'HH24:MI:SS') AS time_only
FROM sales.orders;

-- TASK 10: Custom format: Day Wed Jan Q1 2025 12:34:56 PM
SELECT TO_CHAR(creationtime, '"Day" Dy Mon "Q"Q YYYY HH12:MI:SS AM') AS formatted
FROM sales.orders;

-- TASK 11: Orders per year, formatted "Mon YY"
SELECT TO_CHAR(creationtime, 'Mon YY') AS month_year,
       COUNT(*) AS order_count
FROM sales.orders
GROUP BY month_year
ORDER BY MIN(creationtime);


/* ==============================================================================
   7. CAST()
===============================================================================*/

-- TASK 12/13: Convert data types using CAST
SELECT orderid,
       creationtime,
       CAST(creationtime AS VARCHAR) AS creation_as_text,
       CAST(orderid AS TEXT)         AS orderid_as_text
FROM sales.orders;


/* ==============================================================================
   8. DATE Arithmetic (DATEADD / DATEDIFF equivalents)
===============================================================================*/

-- TASK 14: Add/subtract intervals
SELECT orderid,
       creationtime,
       creationtime + INTERVAL '7 days' AS plus_7_days,
       creationtime - INTERVAL '1 month' AS minus_1_month
FROM sales.orders;

-- TASK 15: Calculate age of employees (assuming employees table with birthdate)
SELECT empid,
       birthdate,
       AGE(CURRENT_DATE, birthdate) AS age_full,
       DATE_PART('year', AGE(CURRENT_DATE, birthdate)) AS age_years
FROM hr.employees;

-- TASK 16: Average shipping duration in days for each month
-- assuming columns: shippeddate, orderdate
SELECT TO_CHAR(orderdate, 'YYYY-Mon') AS month_year,
       AVG(EXTRACT(day FROM (shippeddate - orderdate))) AS avg_shipping_days
FROM sales.orders
WHERE shippeddate IS NOT NULL
GROUP BY month_year
ORDER BY MIN(orderdate);

-- TASK 17: Time gap analysis: days between consecutive orders
SELECT orderid,
       creationtime,
       creationtime - LAG(creationtime) OVER (ORDER BY creationtime) AS days_since_last_order
FROM sales.orders;


/* ==============================================================================
   9. Date Validation (ISDATE equivalent in Postgres)
===============================================================================*/

-- PostgreSQL does not have ISDATE, but we can validate with a safe cast:
-- Returns only rows where string_date can be cast to DATE
SELECT orderid, string_date
FROM some_table
WHERE string_date ~ '^\d{4}-\d{2}-\d{2}$'  -- regex check YYYY-MM-DD
  AND string_date::date IS NOT NULL;

