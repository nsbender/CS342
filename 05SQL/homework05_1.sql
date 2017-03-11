--- Homework 05 ---

-- a. Get a list of the employees who have finished all of their jobs (i.e., all their jobs
-- in the job_history table have non-null end_dates).

SELECT DISTINCT employee_id
FROM Job_history
WHERE end_date IS NOT NULL;

-- b. Get a list of employees along with their manager such that the managers have less
-- seniority at the company and that all the employees’ jobs have been within the manager’s
-- department.

SELECT e.first_name || ' ' || e.last_name AS "Employee Name",
	 m.first_name || ' ' || m.last_name AS "Manager Fullname"
FROM Employees e, Employees m
WHERE m.ID = e.manager_id
AND m.department_id = e.department_id
AND m.hire_date > e.hire_date
AND NOT EXISTS (
	SELECT * FROM job_history j
	WHERE e.employee_id = j.employee_id
	AND j.department_id <> m.department_id
	)
;

-- c. The countries in which at least one department is located. Try to write this as both
-- a join and a nested query. If you can, explain which is better. If you can’t, explain
-- which is not possible and why.

-- Using a join
SELECT DISTINCT c.country_name FROM Countries c
  JOIN Locations l ON c.country_id = l.country_id
  JOIN Departments d ON l.location_id = d.location_id;
  
-- Using a nested query
SELECT DISTINCT C.country_name FROM Countries C WHERE C.country_id WHERE EXISTS(
	SELECT L.country_id FROM Locations L WHERE L.location_id WHERE EXISTS(
		SELECT D.location_id FROM Departments D
		)
	)
;

-- Using a JOIN is costly in terms of processing, but is ultimately better than using a nested
-- Subquery since you are only joining tables a few times, rather than doing an exponential number of
-- subquery calculations