--- Homework10.sql, Nate Bender ---

CREATE OR REPLACE PROCEDURE rankTransfer (movieF IN INT, movieT IN INT, amt IN NUMBER) AS
	rankRangeException EXCEPTION;
	
BEGIN
DECLARE
	rankF NUMBER DEFAULT 0;
	rankT NUMBER DEFAULT 0;
	newRankF NUMBER DEFAULT 0;
	newRankT NUMBER DEFAULT 0;
	
BEGIN
	LOCK TABLE Movie IN EXCLUSIVE MODE; -- Only one query can be working on Movie at a time...
	-- Get the ranks of the original movies (before updating)
	SELECT rank INTO rankF
		FROM Movie
		WHERE id = movieF;
	SELECT rank INTO rankT
		FROM Movie
		WHERE id = movieT;
		
	-- Check to make sure that this wont put the 'from' Movie below 0...
	IF rankF - amt < 0.0 THEN
		RAISE rankRangeException;
	END IF;
	
	-- Apply the amount changes to the 'to' and 'from' Movies
	UPDATE Movie
		SET rank = rank - amt
		WHERE id = movieF;
	UPDATE Movie
		SET rank = rank + amt
		WHERE id = movieT;
		
	COMMIT;
	
	-- Define the exception that checks for a negative rank
	EXCEPTION
		WHEN rankRangeException
			dbms_output.put_line('Rank cannot be less than 0.0 for any Movie!');
			ROLLBACK;
	END;
END;
/

EXECUTE rankTransfer(176711, 176712, .01);