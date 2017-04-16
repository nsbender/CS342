-- Homework09_2.sql, Nate Bender

SET autotrace off;
SET serveroutput on;
SET timing on;

--- Baseline to get a timing for a join

SELECT id, (
	SELECT COUNT(1) FROM MovieDirector WHERE directorid = id
) AS movies
FROM Director
WHERE (
	SELECT COUNT(1) FROM MovieDirector WHERE directorid = id
) > 200;
-- This requires .30 - .48 seconds to complete since the subquery is performing full table
-- access on MovieDirector in multiple subqueries. This is really several times longer that it
-- needs to.


--- Indexing the MovieDirector table

CREATE INDEX MovieDirectorIndex ON MovieDirector(directorid);
-- Re-running the same query as before, I was able to knock off a couple of milliseconds each time
-- but this still seems like a long time. 


--- Grouping directors by movie count & eliminating a range

SELECT directorid, COUNT(1) AS movies FROM MovieDirector
GROUP BY directorid HAVING COUNT(1) > 200
ORDER movies DESC;
-- This requires .06 - .08 seconds since it simply reorders the MovieDirector table by the
-- count of movies a director has done and only considers those who have directed 200+ movies.
-- This is the obvious choice, but feels cheap prgramatically... if it works...