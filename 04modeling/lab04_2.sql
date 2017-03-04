-- This command file loads an experimental person database.
-- The data conforms to the following assumptions:
--     * People can have 0 or many team assignments.
--     * People can have 0 or many visit dates.
--     * Teams and visits don't affect one another.
--
-- CS 342, Spring, 2017
-- kvlinden

DROP TABLE PersonTeam;
DROP TABLE PersonVisit;

CREATE TABLE PersonTeam (
	personName varchar(10),
    teamName varchar(10)
	);

CREATE TABLE PersonVisit (
	personName varchar(10),
    personVisit date
	);

--- A ---

/* PersonTeam and PersonVisit satisfy the following normal forms
 * 1NF - Each attribute does contain only atomic values
 * 2NF - No non-prime attributes have part-key dependencies on any of these candidate keys.
 * 3NF -  "Every non-key attribute provides a fact about the key, the whole key,
 *   and nothing but the key. So help me Codd"
 * and thus meets
 * BCNF - All superkeys are candidate keys
 * and
 * 4NF becuase there are no non-trivial multivalued dependencies other than a candidate key.
*/

-- Load records for two team memberships and two visits for Shamkant.
INSERT INTO PersonTeam VALUES ('Shamkant', 'elders');
INSERT INTO PersonTeam VALUES ('Shamkant', 'executive');
INSERT INTO PersonVisit VALUES ('Shamkant', '22-FEB-2015');
INSERT INTO PersonVisit VALUES ('Shamkant', '1-MAR-2015');

-- Query a combined "view" of the data of the form View(name, team, visit).
SELECT pt.personName, pt.teamName, pv.personVisit
FROM PersonTeam pt, PersonVisit pv
WHERE pt.personName = pv.personName;

--- B ---

/* This reformatted output of the data has a multivalued dependancy of the form
 * personName -> teamName | personVisit. This does not meet 4NF, but it does
 * meet BCNF since there are no functional dependencies
*/

--- C ---

/*
 * The original schema avoids redundant data, as each persons team & visit combinations
 * must be entered as separate entries.
 *
*/
