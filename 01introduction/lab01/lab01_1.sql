/* List all rows of the DEPARTMENTS table */
SELECT * from DEPARTMENTS;

/* Find the number of employees in the database */
SELECT COUNT(*) from EMPLOYEES;

/* list the employees who make more than $15,000 per year */
SELECT * from EMPLOYEES WHERE SALARY > 15000;

/* list the employees who were hired from 2002�2004 (inclusive) */
SELECT * from EMPLOYEES WHERE HIRE_DATE between '01-JAN-02' and '01-JAN-04';

/* list the employees who have a phone number that doesn�t
   have the area code 515 (nb., use NOT LIKE with the wildcard %). */
SELECT * from EMPLOYEES WHERE PHONE_NUMBER NOT LIKE '515.%%%.%%%';

/* list the names of the employees who are in the finance department.
   Try to format the names as �firstname lastname�
   using concatenation (i.e., || ) and order them alphabetically. */
SELECT FIRST_NAME, LAST_NAME FROM EMPLOYEES WHERE DEPARTMENT_ID = 100 ORDER BY FIRST_NAME;

/* list the city, state and country name for all locations in the Asian region. */
SELECT city, state_province, country_name 
FROM LOCATIONS, COUNTRIES, REGIONS
WHERE COUNTRIES.country_id = LOCATIONS.country_id AND REGIONS.region_id = COUNTRIES.region_id AND REGIONS.region_name LIKE 'Asia';

/* list the locations that have no state or province specified in the database */
SELECT * FROM LOCATIONS where STATE_PROVINCE IS NULL;
