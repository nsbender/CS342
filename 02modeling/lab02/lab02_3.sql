/* lab02_3 nsb2 */

DROP SEQUENCE movie_seq;

CREATE SEQUENCE movie_seq
START WITH 7 -- Since I added some movies in lab02_1.sql
INCREMENT BY 1;

INSERT INTO Movie VALUES (movie_seq.nextVal, 'Inglorious Bastards', 2009, 8.3);
INSERT INTO Movie VALUES (movie_seq.nextVal, 'Reservoir Dogs', 1992, 8.4);
INSERT INTO Movie VALUES (movie_seq.nextVal, 'Kill Bill', 2003, 8.1);

--- Question A ---

-- While you don't technically need another sequence for performers,
-- it would be pretty sloppy not to. It would especially be an issue
-- if your movies and performers didn't line up (likely).

--- Question B ---

-- Using sequences in a DDL command file could potentially be problematic
-- because the file is static, but the database isn't. In other words,
-- the sequence definition in the file may specify a START WITH, even though
-- the database doesn't. THis will either create conflicting primary keys
-- or gaps in the primary keys of that table.
