CREATE OR REPLACE PROCEDURE cast_actor (actorIdIn IN Actor.id%type, movieIdIn IN Movie.id%type, roleIn IN string%type)

AS
	--DECLARE movieSearch INT DEFAULT -1;
	actorSearch INT DEFAULT -1;
	roleCount INT DEFAULT 0;
	
BEGIN

	IF actorIdIn IS NULL THEN
		dbms_output.put_line("Actor Not Found");
	ELSE
		dbms_output.put_line("Actor Found. Inserting...");
		
		IF movieIdIn IS NULL THEN
			dbms_output.put_line("Movie Not Found");
		ELSE
			SELECT COUNT(*) INTO roleCount FROM Role WHERE id = movieIdIn;
			IF roleCount < 230 THEN
				SELECT actorId INTO actorSearch FROM Role WHERE actorId = actorIdIn;
				IF actorSearch = actorId THEN
					dbms_output.put_line("Actor already cast in Movie!");
				ELSE
					INSERT INTO Role VALUES (actorId, movieIdIn, roleIn);
				END IF;
			ELSE
				dbms_output.put_line("Movie already has 230 roles!");
			END IF;
		END IF;
	END IF;
				
END;
/