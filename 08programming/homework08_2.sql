--- Homework 8 ---
-- Bacon Number — Implement a tool that loads a table (named BaconTable) with records that specify
-- an actor ID and that actor’s Bacon number. An actor’s bacon number is the length of the
-- shortest path between the actor and Kevin Bacon (KB) in the “co-acting” graph. That is, KB 
-- has bacon number 0; all actors who acted in the same movie as KB have bacon number 1; all 
-- actors who acted in the same movie as some actor with Bacon number 1 but have not acted with 
-- Bacon himself have Bacon number 2, etc. Actors who have never acted with anyone with a bacon
-- number should not have a record in the table. Stronger solutions will be configured so that the
-- number can be based on any actor, not just Kevin Bacon.

DROP TABLE BaconTable;

CREATE TABLE BaconTable(
	actorId INTEGER PRIMARY KEY,
	baconNumber INTEGER
);

CREATE OR REPLACE PROCEDURE baconNumber(actorIdIn IN INTEGER, baconNumIn IN INTEGER) IS
counter INTEGER;
BEGIN
	-- Get a list of all actors that have a common movie with Bacon (id = 22591)
	FOR actor IN (
		SELECT DISTINCT actorId FROM Role WHERE movieId IN (
			SELECT movieId FROM Role WHERE actorIdIn = actorId
		)
	)
	LOOP -- Iterate through the movies without repeating (using the counter)
		SELECT COUNT(*) INTO counter FROM BaconTable 
		WHERE actorId = actor.actorId;
		IF counter > 0 THEN
			UPDATE BaconTable SET baconNumber = baconNumIn
			WHERE actorId = actor.actorId
			AND baconNumber > baconNumIn;
		ELSE
			IF baconNumIn < 41 THEN -- Only 41 movies in the database...
				INSERT INTO BaconTable VALUES (actor.actorId, baconNumIn+1);
				baconNumber(actor.actorId, baconNumIn+1);
			END IF;
		END IF;
	END LOOP;
END;
/

BEGIN
	baconNumber(22591, 0);
END;
/