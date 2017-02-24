-- This command file loads an experimental person relation.
-- The data conforms to the following assumptions:
--     * Person IDs and team names are unique for people and teams respectively.
--     * People can have at most one mentor.
--     * People can be on many teams, but only have one role per team.
--     * Teams meet at only one time.
--
-- CS 342
-- Spring, 2017
-- kvlinden

drop table AltPerson;

CREATE TABLE AltPerson (
	personId integer,
	name varchar(10),
	status char(1),
	mentorId integer,
	mentorName varchar(10),
	mentorStatus char(1),
    teamName varchar(10),
    teamRole varchar(10),
    teamTime varchar(10)
	);

-- The original relation is not well designed for multiple reasons.
-- It has no primary key, for the AltPerson,
-- Mentor should be its own table, and the AltPerson should point to
--   its Mentor via a foregin key (mentorId)
-- Team should also be its own Table with a primary teamID key added,
-- but teamRole could be left as a key in AltPerson.

-- With these two additional tables, the schema would be normalized,
-- have no redundant data, and would meet, 1NF, 2NF, 
	
INSERT INTO AltPerson VALUES (0, 'Ramez', 'v', 1, 'Shamkant', 'm', 'elders', 'trainee', 'Monday');
INSERT INTO AltPerson VALUES (1, 'Shamkant', 'm', NULL, NULL, NULL, 'elders', 'chair', 'Monday');
INSERT INTO AltPerson VALUES (1, 'Shamkant', 'm', NULL, NULL, NULL, 'executive', 'protem', 'Wednesday');
INSERT INTO AltPerson VALUES (2, 'Jennifer', 'v', 3, 'Jeff', 'm', 'deacons', 'treasurer', 'Tuesday');
INSERT INTO AltPerson VALUES (3, 'Jeff', 'm', NULL, NULL, NULL, 'deacons', 'chair', 'Tuesday');


