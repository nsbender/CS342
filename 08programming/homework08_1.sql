--- Homework 8 ---
-- 1. Auditing — Implement a “shadow” log that records every update to the rank of any 
-- Movie record. Store your log in a separate table ( RankLog ) and include the ID of the 
-- user who made the change (accessed using the system constant user), the date of the
-- change (accessed using sysdate) and both the original and the modified ranking values.

	CREATE TABLE RankLog (
		userId varchar(30),
		movieId integer,
		changeDate date,
		oldscore number(10,2),
		newscore number(10,2)
	);
	
	CREATE OR REPLACE TRIGGER RankChange AFTER UPDATE ON Movie FOR EACH ROW
	BEGIN
		INSERT INTO RankLog VALUES (user, :old.id, sysdate, :old.rank, :new.rank );
	END;
		