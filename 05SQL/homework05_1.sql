--- Homework 05 ---

-- a. Get a list of the employees who have finished all of their jobs (i.e., all their jobs
-- in the job_history table have non-null end_dates).

SELECT DISTINCT employee_id
FROM Job_history
WHERE end_date IS NOT NULL;

-- b. Get a list of employees along with their manager such that the managers have less
-- seniority at the company and that all the employees’ jobs have been within the manager’s
-- department.

SELECT first_name, last_name
FROM Employees
WHERE manager_id IS NOT NULL;

-- c. The countries in which at least one department is located. Try to write this as both
-- a join and a nested query. If you can, explain which is better. If you can’t, explain
-- which is not possible and why.