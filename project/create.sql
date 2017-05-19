-- Create the beerdb user and database.
-- See ../README.txt for details.

-- Create the user.
DROP USER beerdb CASCADE;
CREATE USER beerdb
	IDENTIFIED BY bjarne
	QUOTA 100M ON System;
GRANT
	CONNECT,
	CREATE TABLE,
	CREATE SESSION,
	CREATE SEQUENCE,
	CREATE VIEW,
	CREATE MATERIALIZED VIEW,
	CREATE PROCEDURE,
	CREATE TRIGGER,
	UNLIMITED TABLESPACE
	TO beerdb;



-- Needed for dumping...
GRANT IMP_FULL_DATABASE, EXP_FULL_DATABASE TO beerdb;

@load
-- Load the DB to be dumped using the standard definition files.
-- Connect to the user's account/schema.
CONNECT beerdb/beerdb;

--DEFINE imdb=C:\projects\cs342\projects\cs342\p\databases\imdbLarge
--@&imdb\load
