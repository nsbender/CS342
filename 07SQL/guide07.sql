--- Views (Section 7.3, for Monday) ---
-- Write a simple view specification. For details on Oracle views, see Managing Views.

	CREATE VIEW Director_movie AS
	SELECT d.firstName, d.lastName, m.name
	FROM Director d, Movie m
	WHERE d.id = 1;

-- Define the following terms (in the comments of your SQL command file).

-- Base Tables: The tables on which a view specification is based. Can be tables, and might be views
-- themselves. Operations performed on a view affect the actual base tables

-- Join Views: Views that specify more than one baste table/view in the FROM clause

-- Updateable Join Views: A join view where UPDATE, INSERT, and DElETE operations are allowed

-- Key-Preserved Tables: A table in which every key of the table can also be a key of the result of the join.
-- Thus, the keys are preserved through a join.

-- Views that are implemented via query modification vs materialization: Materialized view are stored on disk,
-- and are updated based on the query definition. Modified views are only created each time they are accessed.