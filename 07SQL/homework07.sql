--- Homework07 ---
-- Do the following exercises on the HR database 

-- 1. Create a view of all employees and their department; include the employee ID, name, email, hire date
-- and department name. 

		CREATE VIEW Employee_dept AS
		SELECT 	e.employee_id,
				e.first_name || ' ' || e.last_name name,
				e.email,
				e.hire_date
				d.department_name
		FROM Employees e, Departments d
		WHERE d.department_id = e.department_id;

	-- Then write SQL commands to do the following:
	-- a. Get the name and ID of the newest employee in the “Executive” department.

		SELECT * FROM Employee_dept
		WHERE department_name = 'Executive'
		ORDER BY hire_date ASC
		LIMIT 1;
		
		-- Works, since we are only querying the 'virtual' view

	-- b. Change the name of the “Administration” department to “Bean Counting”.

		UPDATE Employee_dept
		SET department_name = 'Bean Counting'
		WHERE department_name = 'Administration';
		
		-- Does not work, since department name is referenced in multiple tables in the views definition
	
	-- c. Change the name of “Jose Manuel” to just “Manuel”

		UPDATE Employee_dept
		SET name = 'Manuel'
		WHERE name = 'Jose Manuel';
		
		-- Does not work, since name is not a column in either of the original tables
	
	-- d. Insert a new employee in the “Payroll” department (make up appropriate data for this record).
	
		INSERT INTO Employee_dept VALUES (1729, 'Nathaniel Bender', 'nsb2', "17-JUN-2017", "Payroll");
		
		-- Does not work since name is not an original column in the tables.

-- 2. Redo the previous exercise with a materialized view.

		CREATE MATERIALIZED VIEW Employee_dept2 FOR UPDATE AS
		SELECT 	e.employee_id,
				e.first_name || ' ' || e.last_name,
				e.email,
				e.hire_date
				d.department_name
		FROM Employees e, Departments d
		WHERE d.department_id = e.department_id;
	
	-- a. Get the name and ID of the newest employee in the “Executive” department.

		SELECT * FROM Employee_dept2
		WHERE department_name = 'Executive'
		ORDER BY hire_date ASC
		LIMIT 1;
		
		-- Works okay, since our Materialized view is FOR UPDATE

	-- b. Change the name of the “Administration” department to “Bean Counting”.

		UPDATE Employee_dept2
		SET department_name = 'Bean Counting'
		WHERE department_name = 'Administration';
		
		-- Works okay, since our Materialized view is FOR UPDATE

	-- c. Change the name of “Jose Manuel” to just “Manuel”

		UPDATE Employee_dept2
		SET name = 'Manuel'
		WHERE name = 'Jose Manuel';
		
		-- Works okay, since our Materialized view is FOR UPDATE

	-- d. Insert a new employee in the “Payroll” department (make up appropriate data for this record).
	
		INSERT INTO Employee_dept2 VALUES (1729, 'Nathaniel Bender', 'nsb2', "17-JUN-2017", "Payroll");
		
		-- Works okay, since our Materialized view is FOR UPDATE

-- 3. Write the following queries as specified:
	-- a. The query on which your view from exercise 1 is based - Write this query using both the
	-- relational algebra and tuple relational calculus, with respect to the original HR relations.
	
	
	
	-- b. The query from exercise 1.a - Write this query using (only) the relational calculus, with
	-- respect to DeptView.