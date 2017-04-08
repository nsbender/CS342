--- Lab 08 Part 2 ---
-- Write a recursive procedure to creates a temporary table and loads it with the IDs and names
-- of all the sequels of a given movie (identified by movie ID #), including sequels of sequels.
-- Look forward in time (i.e., list Ocean’s Twelve for Ocean’s Eleven but not vice-versa) and you
-- can assume that there will be no cycles in the sequel chains. Demonstrate that your procedure
-- works by trying the following.

-- a. Find the sequels of Ocean’s 11 (#238072).

	CREATE TABLE SequelsResults (
		id INTEGER,
		name varchar2(100),
		PRIMARY KEY (id)
	 );

	CREATE OR REPLACE PROCEDURE getSequels (movie_id in Movie.id%type) AS
		CURSOR sequels IS
			SELECT sequelId FROM Movie WHERE id = movie_id;
	BEGIN
		DELETE FROM SequelsResults;
		FOR sequel IN sequels LOOP
			getSequels(sequel.sequelId);
			INSERT INTO SequelsResults (
				SELECT id, name FROM Movie WHERE id = sequel.sequelId
			);
		END LOOP;
	END;
	/
	
	BEGIN
		getSequels(238071); -- Id for Ocean's 11
	END;
	/
			
-- b. Find the sequels of Ocean’s Fourteen (#238075).

	BEGIN
		getSequels(238075); -- Id for Ocean's 14
	END;
	/