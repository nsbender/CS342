-- Starter code for lab 3.
--
-- CS 342, Spring, 2017
-- kvlinden
-- Completed by Nate Bender

drop table Person;
drop table Household;
drop table Request;
drop table PersonTeam;
drop table Team;
drop table HomeGroup;


create table Household(
	ID integer PRIMARY KEY,
	street varchar(30),
	city varchar(30),
	state varchar(2),
	zipcode char(5),
	phoneNumber char(12)
	);

create table Homegroup(
	ID integer PRIMARY KEY,
	name varchar(30),
	description varchar(140),
	day varchar(2) CHECK (day IN ('M', 'Tu', 'W', 'Th', 'F', 'Sa', 'Su')),
	location varchar(20)
);

create table Team(
	ID integer PRIMARY KEY,
	name varchar(30),
	mandate varchar(140),
	day varchar(2) CHECK (day IN ('M', 'Tu', 'W', 'Th', 'F', 'Sa', 'Su')),
	location varchar(20)
);

create table Person (
	ID integer PRIMARY KEY,
	title varchar(8),
	firstName varchar(15),
	lastName varchar(15),
	membershipStatus char(1) CHECK (membershipStatus IN ('m', 'a', 'c'),
	householdID integer,
	mentorID integer,
	homegroupID integer,
	role varchar(30), -- I dont think this should be limited to a list...
	FOREIGN KEY (houseHoldID) REFERENCES HouseHold(ID) ON DELETE SET NULL,
  FOREIGN KEY (mentorID) REFERENCES Person(ID) ON DELETE SET NULL,
  FOREIGN KEY (homegroupID) REFERENCES Homegroup(ID) ON DELETE SET NULL
);

create table Person_Team(
	TeamID integer,
	PersonID integer,
	role varchar(30),
	startDate date,
  endDate date,
	Primary Key (TeamID, PersonID),
	Foreign Key (TeamID) REFERENCES Team(ID) ON DELETE SET NULL,
	Foreign Key (PersonID) REFERENCES Person(ID) ON DELETE SET NULL
);

create table Request (
	requestor integer,
	responder integer,
	submitDate date,
	text varchar(256),
	response varchar(256),
	accessCode char,
	PRIMARY KEY (requestor, responder, submitDate),
	FOREIGN KEY (requestor) REFERENCES Household(ID) ON DELETE SET NULL,
	FOREIGN KEY (responder) REFERENCES Person(ID) ON DELETE SET NULL
	);

	/* Be sure to prevent and NULLify invalid references */
	FOREIGN KEY(mentorID) REFERENCES Person(ID) ON DELETE SET NULL,
	FOREIGN KEY(householdID) REFERENCES Household(ID) ON DELETE SET NULL,
	CHECK (mentorID >= 0 OR mentorID IS NULL)
	);

INSERT INTO Household VALUES (0,'2347 Oxford Dr. SE','Grand Rapids','MI','49506','616-243-5680');
INSERT INTO Household VALUES (1, '1234 Burton St. SE','Grand Rapids','MI','49546','616-123-6543');
INSERT INTO Household VALUES (2, '1357 Woodcliff Ave','Grand Rapids','MI','49546','616-222-1800')

INSERT INTO Person VALUES (0,'mr.','Keith','VanderLinden','m',0,NULL,2,'Married');
INSERT INTO Person VALUES (1,'ms.','Brenda','VanderLinden','m',0,NULL,2,'Married');
INSERT INTO Person VALUES (2,'mr.','Nate','Bender','m',1,0,1,'Student');
INSERT INTO Person VALUES (3,'mr.','Adam','Christensen','m',1,1,1,'Student');

INSERT INTO Homegroup VALUES (0, 'Bible for Educators','Bible Study for teachers and professors', 'M', 'Sanctuary');
INSERT INTO Homegroup VALUES (1, 'Student Recovery','A time for students to meditate on the word', 'Sa', 'Cafeteria');

INSERT INTO Teams VALUES (0, 'Post Service Refreshments Team','Providing coffee and snacks for all events','Su','Cafeteria');
INSERT INTO Teams VALUES (1,'Office Staff','Administrative functions','W','Office');

INSERT INTO Person_Team VALUES (0, 2, 'Doughnuts', DATE '2017-02-01', NULL );
INSERT INTO Person_Team VALUES (1, 3, 'Intern', DATE '2016-03-11', NULL );

INSERT INTO Request (2,3,'2017-02-22','I need help on my databases lab!','I haven\'t taken that class...','a');
INSERT INTO Request (3,0,'2017-02-23','I would like tutoring in Databases','I can do that!','b');
