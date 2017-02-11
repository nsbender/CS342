/* lab02_1 nsb2 */

/* ---------PART A--------- */

/* Inserting an erraneous duplicated primary key */
INSERT INTO Performer VALUES (1,'Harrison Ford 2.0');
/* Outputs  'ORA-00001: unique constraint (NSB2.SYS_C007000) violated' since id
    is specified as the PRIMARY KEY */

/* Inserting an erraneous NULL primary key */
INSERT INTO Performer VALUES (NULL,'NULLison Ford');
/* Outputs 'ORA-01400: cannot insert NULL into ("NSB2"."PERFORMER"."ID")' since an
    an id cannot be a null PRIMARY KEY */

/* Violating a CHECK key */
INSERT INTO Movie VALUES (3,'A Very Old Film',1890, 9.0);
/* Outputs 'ORA-02290: check constraint (NSB2.SYS_C006998) violated' since the
    the film's year is invalid according to the definition of the Movie table */

/* Violating a data type */
INSERT INTO Movie VALUES (4,'Strange Ratings',2000, 'Two Thumbs Up');
/* Outputs 'ORA-01722: invalid number' since the third field of a film is expecting
    a float value, not the string that was found in this case */

/* Inserting a negatively scored film */
INSERT INTO Movie VALUES (5, 'Very Poorly Rated', 2010, -5.0);
/* Returns that a row was successfully added. We never specified that a score has
    to be higher than 0.0, so as far as the Table is concerned this is fine */

/* ---------PART B--------- */

/* Inserting a row with a NULL foreign key */
INSERT INTO Casting VALUES (1,NULL,'star');
/* Returns that a row was successfully added. The Performer is allowed to be NULL
    for a film since we never specified that it cant be. */

/* Inserting a row with a non-existant foreign key */
INSERT INTO Casting VALUES (1,5,'star');
/* Returns 'ORA-02291: integrity constraint (NSB2.SYS_C007003) violated - parent key
    not found' since the Casting table now references a non-existant actor*/

/* Inserting a key value in a referenced table with no related records in the referencing table */
INSERT INTO Movie VALUES (6,'Pulp Fiction',1994, 8.9);
/* Successfully creates a row since a Movie may be referenced by a Casting, but doesn'table
    have to be. */

/* ---------PART C--------- */

/* Delete a referenced record that is referenced by a referencing record */
DELETE FROM Movie WHERE id = 1;
/* Successfully deletes the movie, but makes the Casting table invalid */

/* Delete a referencing record that references a referenced record */
DELETE FROM Casting WHERE movieId = 1 AND performerId = 1;
/* Successfully deletes the Casting. This simply means that Harrison Ford was never
    featured in Star Wars. Its not technically true, but it is valid */

/* Modify the ID of a movie record that is referenced by a casting record */
UPDATE Movie SET id=7 WHERE id=2;
/* Returns 'ORA-02292: integrity constraint (CPD5.SYS_C007016) violated - child record'
    since there is a child record in Casting which refers to the Movie of id 2. After
		changing that, the record is no longer valid */
