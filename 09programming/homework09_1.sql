-- Homework09.sql, Nate Bender

SET autotrace off;
SET serveroutput on;
SET timing on;

--- Baseline to get a timing for a join

select M.id, M.name, M.year, M.rank from Movie M
join MovieDirector MD on M.id = MD.movieid
join Director D on D.id = MD.directorid
where D.firstname = 'Clint' and D.lastname = 'Eastwood';
-- Completed in .02 - .06 seconds


--- Indexing the Director table

create index DirectorNameIndex on Director(firstname, lastname);
-- then
select M.id, M.name, M.year, M.rank from Movie M
join MovieDirector MD on M.id = MD.movieid
join Director D on D.id = MD.directorid
where D.firstname = 'Clint' and D.lastname = 'Eastwood';
-- Completed in .02 - .05 seconds, which seems negligible compared to the first query, but may be margainal


--- Indexing the MovieDirector table

create index MovieDirectorDirectorIndex on MovieDirector(directorid);
-- then
select M.id, M.name, M.year, M.rank from Movie M
join MovieDirector MD on M.id = MD.movieid
join Director D on D.id = MD.directorid
where D.firstname = 'Clint' and D.lastname = 'Eastwood';
-- Completed in .03 - .08 seconds. This is noticeably slower, but I am unsure why. I'd like to keep expirimenting
-- with joined indexes like this one to see why this is happening...


-- Between the two of these queries, the first Index seems to have been more effective (even if its timing
-- was negligible). This may because its not considering the full range of directors, but rather only the 
-- ones that match a range. Still may not be fully optimized but conceptually, it seems to be an improvement