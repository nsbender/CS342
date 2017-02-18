/* lab02_2 nsb2 */
-- Exercise 2.3

DROP TABLE Casting;
DROP TABLE Movie;
DROP TABLE StatusType;
DROP TABLE Performer;

-- From original Movie schema
CREATE TABLE Movie (
	id integer,
	title varchar(70) NOT NULL,
	year decimal(4),
	score float,
	PRIMARY KEY (id),
	CHECK (year > 1900)
);

CREATE TABLE Performer (
  id integer,
  name varchar(35),
  PRIMARY KEY (id)
);

CREATE TABLE StatusType (
  id integer,
  name varchar(20),
  PRIMARY KEY (id)
);

CREATE TABLE Casting (
  movieId integer,
  performerId integer,
  status integer,
  FOREIGN KEY (movieId) REFERENCES Movie(Id) ON DELETE CASCADE,
  FOREIGN KEY (performerId) REFERENCES Performer(Id) ON DELETE SET NULL,
  FOREIGN KEY (status) REFERENCES StatusType(Id) ON DELETE SET NULL
);

-- This new StatusType table allows you to specify a status in the
-- casting table rather than specifying it as a definition in the Casting
-- This saves some work later on. Re-defining tables is a pain.
