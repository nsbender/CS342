--- Exercise 9.1
-- Build sample queries to test that:

-- a. There is a benefit to using either COUNT(1) , COUNT(*) or SUM(1) for simple counting
--  queries.

	SELECT COUNT (*) FROM Actor; -- Elapsed time 00.01 - 00.03 Seconds
	SELECT COUNT (1) FROM Actor; -- Elapsed time 00.01 - 00.03 Seconds
	SELECT SUM (1) FROM Actor; -- Elapsed time 00.01 - 0.03 Seconds
	
	/* The concensus on the internet seems to be that count(1) isn't faster just because
	 *  its only looking at one column, and my results seem to back that up. In fact, I've
	 *  also read that Oracle just converts COUNT(1) to COUNT(*) internally anyway, so there
	 *  really shouldn't be a difference if this is the case
	 */
	 
-- b. The order of the tables listed in the FROM clause affects the way Oracle executes
--  a join query.

	SELECT a.firstName || a.lastName AS ActorName, m.name
	FROM Movie m, Actor a, Role r
	WHERE r.actorId = a.id
	AND r.movieId = m.id
	AND m.year = 2000; -- Completes in 00.46 seconds
	
	SELECT a.firstName || a.lastName AS ActorName, m.name
	FROM Actor a, Role r, Movie m
	WHERE r.actorId = a.id
	AND r.movieId = m.id
	AND m.year = 2000; -- Completes in 00.46 seconds
	
	SELECT a.firstName || a.lastName AS ActorName, m.name
	FROM Role r, Movie m, Actor a
	WHERE r.actorId = a.id
	AND r.movieId = m.id
	AND m.year >= 2000; -- Completes in 00.45 seconds	
	
	/* From what these queries show, join order doesn't matter. Obviously the size of
	 * the tables being joined would make a difference, but re-ordering the same table
	 * between queries is negligible. 
	 */

-- c. The use of arithmetic expressions in join conditions (e.g., FROM Table1 JOIN Table2 
--  ON Table1.id+0=Table2.id+0 ) affects a query’s efficiency.

-- d. Running the same query more than once affects its performance.

	SELECT a.firstName || a.lastName AS ActorName, m.name
	FROM Role r, Movie m, Actor a
	WHERE r.actorId = a.id
	AND r.movieId = m.id
	AND m.rank <= 3;
	/* Completes in 00.35 seconds regardless of how many times it is
	 * run. Oracle doesn't cache results unless we do something like:
	 */

	CREATE OR REPLACE VIEW ActorView AS
	SELECT id, firstName, lastName
	FROM Actor;
	/* Which never takes more that 00.00 seconds after the first time its called,
	 * which takes 00.03 seconds
	 */
	 
-- e. Adding a concatenated index on a join table improves performance (see the create
--  index command described above).

	SELECT d.firstName || d.lastName AS directorName, m.name
	FROM Director d, Movie m, MovieDirector md
	WHERE d.id = md.directorId
	AND m.id = md.movieId;
	-- Completes in 00.96 seconds, whereas
	
	SELECT m.name || ' - ' || d.firstName || d.lastName AS directorName
	FROM Director d, Movie m, MovieDirector md
	WHERE d.id = md.directorId
	AND m.id = md.movieId;
	-- Completes in 00.91 seconds consistently which is non-negligibly faster.
	
