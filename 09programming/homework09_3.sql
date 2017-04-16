-- Homework09_3.sql, Nate Bender (imdb large)

SET autotrace off;
SET serveroutput on;
SET timing on;


--- Baseline to get a timing for a JOIN and an AVERAGE

SELECT R.actorid FROM Role R
JOIN Movie M ON M.id = R.movieid
GROUP BY R.actorid
HAVING AVG(M.rank) > 8.5 AND COUNT(1) > 10
ORDER BY AVG(M.rank);
-- This requires 1.98 - 2.10 seconds because of the aggregate functions, full scans, and join


--- Creating index for actor

CREATE INDEX0 actorIndex ON Actor (firstName, lastName, id);
-- Re-running the same query as before with the new index on actor makes no difference. This is
-- likely because the actors are already indexed by id so creating a new one has no effect.