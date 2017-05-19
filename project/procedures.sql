-- This procedure allows a user to specify a beer by its ID and delete it.
-- It locks the two tables that would reference the beer to ensure no data is removed
-- during another transaction.

CREATE OR REPLACE PROCEDURE DeleteBeer (beerId in integer) AS
BEGIN
	LOCK TABLE Beer IN SHARE MODE;
	LOCK TABLE DistributorBeer IN SHARE MODE;
	
	SAVEPOINT;
	DELETE FROM Beer WHERE id = beerId;
	
	SAVEPOINT;
	DELETE FROM DistributoBeer WHERE beerId = beerId;
	
	COMMIT;
END;
