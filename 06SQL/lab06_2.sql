--- Exercise 6.2 ---
-- a. Compute the average age of all the people in the database.

SELECT AVG(TRUNC(MONTHS_BETWEEN(SYSDATE, birthdate))/12) "Average Age"
FROM Person;

-- b. Get the household ID and count of members of all households in
-- Grand Rapids having at least 2 members. Order the results by decreasing size.

SELECT HouseHold.ID, COUNT(Person.householdID) members
FROM HouseHold, Person
WHERE Person.householdID = HouseHold.ID
AND HouseHold.city = 'Grand Rapids'
GROUP BY HouseHold.ID;

-- c. Modify the previous query to retrieve the phone number of the household as well.
SELECT HouseHold.ID, HouseHold.phoneNumber, COUNT(Person.householdID) members
FROM HouseHold, Person
WHERE Person.householdID = HouseHold.ID
AND HouseHold.city = 'Grand Rapids'
GROUP BY HouseHold.ID, HouseHold.phoneNumber;