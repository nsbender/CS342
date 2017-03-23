--- Exercise 7.1 ---
--- Create a view that for the CPDB “birthday czar” that includes each person’s full name,
--- age (using TRUNC(MONTHS_BETWEEN(SYSDATE, birthdate)/12) ) and birthdate (only), and 
--- then write commands that:

	CREATE VIEW Birthday_Czar AS
	SELECT Person.firstName, 
		Person.lastName, 
		TRUNC(MONTHS_BETWEEN(SYSDATE, Person.birthdate)/12) age,
		Person.birthdate
	FROM Person;

-- a. Retrieve the GenX people from the database (i.e., those born from 1961–1975).

	SELECT * FROM Birthday_Czar
	WHERE EXTRACT(year FROM birthdate) > 1960
	AND EXTRACT(year FROM birthdate) < 1976;

-- b. Update the Person base table to include a GenX birthdate for some person who had age
-- NULL birthdate before. Now, try to re-run your query on the view from the previous
-- question. Do the results of the view query change? Why or why not?

	-- After running
	UPDATE Person SET birthdate = '17-JUN-1970' WHERE id=7;
	-- which gives person 7 (whose birthdate was previously NULL) a GenX birthdate,
	-- the view query returns the update person. This is because this view actually 
	-- reflects the real table, and creates it as needed.
	

-- c. Insert a new person using your new view. If this doesn’t work, explain (but do not
-- implement) the modifications you’d have to make to your view so that it does. Be sure
-- that you understand what is required for a view to be updateable and what happens to the
-- fields of the inserted record in the base table not included in the view.

	-- After running
	INSERT INTO Birthday_Czar VALUES (Nathaniel, Bender, 21, '17-JUN-1995');
	-- an error is returned since age is a virtual column that is calculated from a real
	-- column, and thus Oracle has no idea what type of data to insert into the original
	-- table. In order for the view to be updateable, each of the columns would need to 
	-- preserved in the creation of the join such that each column actually corresponded
	-- to a column in the original table. We would need to remove the TRUNC calculated
	-- age.

-- d. Drop your new view. Does this affect your base tables in any way?

	-- DROPping the view has no effect on the table since it is just a virtualization
	-- of some of the columns of the Person table.
