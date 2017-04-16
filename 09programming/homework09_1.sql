-- Homework09_1.sql, Nate Bender

SET autotrace off;
SET serveroutput ON;
SET timing ON;

--- Baseline to get a timing for a JOIN

SELECT M.id, M.name, M.year, M.rank FROM Movie M
JOIN MovieDirector MD ON M.id = MD.movieid
JOIN Director D ON D.id = MD.directorid
WHERE D.firstname = 'Clint' AND D.lastname = 'Eastwood';
-- Completed in .02 - .06 secONds


--- Indexing the Director table

CREATE INDEX DirectorNameIndex ON Director(firstname, lastname);
-- then
SELECT M.id, M.name, M.year, M.rank FROM Movie M
JOIN MovieDirector MD ON M.id = MD.movieid
JOIN Director D ON D.id = MD.directorid
WHERE D.firstname = 'Clint' AND D.lastname = 'Eastwood';
-- Completed in .02 - .05 secONds, which seems negligible compared to the first query, but may be margainal


--- Indexing the MovieDirector table

CREATE INDEX MovieDirectorDirectorIndex ON MovieDirector(directorid);
-- then
SELECT M.id, M.name, M.year, M.rank FROM Movie M
JOIN MovieDirector MD ON M.id = MD.movieid
JOIN Director D ON D.id = MD.directorid
WHERE D.firstname = 'Clint' AND D.lastname = 'Eastwood';
-- Completed in .03 - .08 secONds. This is noticeably slower, but I am unsure why. I'd like to keep expirimenting
-- with JOINed indexes like this ONe to see why this is happening...


-- Between the two of these queries, the first Index seems to have been more effective (even if its timing
-- was negligible). This may because its not cONsidering the full range of directors, but rather ONly the 
-- ONes that match a range. Still may not be fully optimized but cONceptually, it seems to be an improvement