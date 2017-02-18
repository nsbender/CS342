-- Starter code for lab 3.
--
-- CS 342, Spring, 2017
-- kvlinden
-- Completed by Nate Bender

drop table Person;
drop table HouseHold;

create table HouseHold(
	ID integer PRIMARY KEY,
	street varchar(30),
	city varchar(30),
	state varchar(2),
	zipcode char(5),
	phoneNumber char(12)
	);

create table Person (
	ID integer PRIMARY KEY,
	title varchar(4),
	firstName varchar(15),
	lastName varchar(15),
	mentorID integer,
	role varchar(30),
	membershipStatus char(1) CHECK (membershipStatus IN ('m', 'a', 'c'	)),
	
	/* Be sure to prevent and NULLify invalid references */
	FOREIGN KEY(mentorID) REFERENCES Person(ID) ON DELETE SET NULL,
	FOREIGN KEY(householdID) REFERENCES HouseHold(ID) ON DELETE SET NULL,
	CHECK (mentorID >= 0 OR mentorID IS NULL)
	);


INSERT INTO Household VALUES (0,'2347 Oxford Dr. SE','Grand Rapids','MI','49506','616-243-5680');

INSERT INTO Person VALUES (0,'mr.','Keith','VanderLinden','m');
INSERT INTO Person VALUES (1,'ms.','Brenda','VanderLinden','m');

