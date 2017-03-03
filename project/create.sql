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

-- Connect to the user's account/schema.
CONNECT beerdb/bjarne;

-- (Re)Create the database.
DEFINE beerdb=D:cs342\project\databases\beerdb
@&beerdb\load
