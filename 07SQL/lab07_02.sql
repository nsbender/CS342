--- Exercise 7.2 ---
-- Repeat the previous exercise, but this time use a materialized view. Pay particular attention to what changes
-- in the view and in the table respectively.

	CREATE MATERIALIZED VIEW Birthday_Czar2 AS
	SELECT firstName, 
		lastName, 
		TRUNC(MONTHS_BETWEEN(SYSDATE, birthdate)/12) age,
		birthdate
	FROM Person;

-- a. Retrieve the GenX people from the database (i.e., those born from 1961–1975).

	SELECT * FROM Birthday_Czar2
	WHERE EXTRACT(year FROM birthdate) > 1960
	AND EXTRACT(year FROM birthdate) < 1976;

-- b. Update the Person base table to include a GenX birthdate for some person who had age
-- NULL birthdate before. Now, try to re-run your query on the view from the previous
-- question. Do the results of the view query change? Why or why not?

	-- After running
	UPDATE Person SET birthdate = '17-JUN-1970' WHERE id=7;
	-- which gives person 7 (whose birthdate was previously NULL) a GenX birthdate,
	-- the view query DOES NOT return the updated person. This is because a materialized 
	-- view is created when the CREATE MATERIALIZED VIEW query was run, taking a sort of
	-- 'snapshot' of the original table.
	

-- c. Insert a new person using your new view. If this doesn’t work, explain (but do not
-- implement) the modifications you’d have to make to your view so that it does. Be sure
-- that you understand what is required for a view to be updateable and what happens to the
-- fields of the inserted record in the base table not included in the view.

	-- After running
	INSERT INTO Birthday_Czar VALUES (Nathaniel, Benderoo, 21, '17-JUN-1995');
	-- an error is returned since I did not specify that the view was updateable with 
	-- CREATE MATERIALIZED VIEW Birthday_Czar2 FOR UPDATE AS. Additionally, inserting into
	-- this view invalidates it as a valid copy of the original table. In this case, perhaps
	-- its better to use a non-materialized view?

-- d. Drop your new view. Does this affect your base tables in any way?

	-- DROPping the materialized view has no effect on the table since it is just a copy
	-- of some of the columns of the Person table.