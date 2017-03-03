-- Exercise 5.1

-- a. Retrieve the cross-product of all person and all household records. 
-- How many records to you get and why?

SELECT * FROM Person, HouseHold;

-- This returns 128 records since there are 16 records in Person,
-- and 8 in HouseHold; The cardinality of the cross-product of two
-- tables will always be equal to the product of the tables' cardinalities.

-- b. Retrieve the people who have birthdays specified in the database,
-- ordered by day-of-year (i.e., Jan 1 birthdays go before Jan 2 
-- birthdays, regardless of the year). Note that you can compute the
-- day of year value using the Oracle function: TO_CHAR(birthdate, 'DDD').

SELECT * FROM Person
WHERE birthdate IS NOT NULL
ORDER BY TO_CHAR(birthdate, 'DDD');
