/* ============================================================================== 
   SQL Number Functions Guide
-------------------------------------------------------------------------------
   This document provides an overview of SQL number functions, which allow 
   performing mathematical operations and formatting numerical values.

   Table of Contents:
     1. Rounding Functions
        - ROUND
     2. Absolute Value Function
        - ABS
=================================================================================
*/

/* ============================================================================== 
   ROUND() - Rounding Numbers
=============================================================================== */

-- Demonstrate rounding a number to different decimal places
select 
    3.516 as original_number,
    round(3.516, 2) as round_2,
    round(3.516, 1) as round_1,
    round(3.516, 0) as round_0

/* ============================================================================== 
   ABS() - Absolute Value
=============================================================================== */

-- Demonstrate absolute value function
select 
    -10 as original_number,
    abs(-10) as absolute_value_negative,
    abs(10) as absolute_value_positive