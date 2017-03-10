--- Exercise 6.1 ---

-- a. Get the names and mandate statements of all teams along with the ID of their “chair” 
-- member. If a chair member does not exist, include NULL for the ID.

SELECT t.name,t.mandate,PersonTeam.personID
FROM Team t
LEFT OUTER JOIN PersonTeam
ON t.name = PersonTeam.teamName
WHERE PersonTeam.role = 'chair';

-- b. [Optional] If you’re looking for a challenge, modify the previous query to return
-- the chair person’s full name instead of just their ID.