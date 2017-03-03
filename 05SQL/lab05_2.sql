-- Exercise 5.2

-- a. Get the youngest person in the database. Write this both as a sub-select 
-- and as a ROWNUM query (see the notes below). Consider implementing your 
-- sub-select without using aggregate functions (e.g., MAX()).

SELECT firstName,lastName,birthdate 
FROM (
	SELECT * FROM Person
	ORDER BY TO_CHAR(birthdate, 'DDD')
)
 WHERE birthdate IS NOT NULL AND ROWNUM = 1;