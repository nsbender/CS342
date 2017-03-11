--- Lab05_03 ---

-- a. Produce an appropriate phone-book entry for “traditional” family entries, e.g.:
-- VanderLinden, Keith and Brenda - 111-222-3333 - 2347 Oxford St.

SELECT DISTINCT p1.lastName || ', ' ||  p2.firstName || ' and ' || p2.firstName ||' - ' || h.phoneNumber ||  ' - ' || h.street AS Families
FROM ((Person p1 JOIN Person p2 ON p1.householdID = p2.householdID)
JOIN Household h ON h.ID = p1.householdID)
WHERE (p1.householdRole LIKE 'husband' AND p2.householdRole LIKE 'wife');

-- b. Extend your solution to handle families in which both spouses keep their own names, e.g.:
-- VanderLinden, Keith and Brenda Roorda - 111-222-3333 - 2347 Oxford St.

-- Essentially the same. While names are different, householdID remains the same

SELECT DISTINCT p1.lastName || ', ' ||  p1.firstName || ' and ' || p2.firstName || ' '|| p2.lastName ||' - ' || H.phoneNumber ||  ' - ' || H.street AS NONTraditional_Family_Entries
FROM ((Person p1 JOIN Person p2 ON p1.householdID = p2.householdID)
JOIN Household h ON h.ID = p1.householdID)
WHERE (p1.householdRole LIKE 'husband' AND p2.householdRole LIKE 'wife')
AND p1.ID <> p2.ID;

-- c. Finally, extend your solution to include single-adult families, e.g.:
-- Doe, Jane - 111-222-3333 - 2347 Main St.