-- The Beer_Basics view returns a summary of each beer for when detailed information is not required.
-- Additionally, it computes each beers average user score if the beer has more than one score.
CREATE OR REPLACE VIEW Beer_Basics AS
SELECT DISTINCT b.name, br.name AS BreweryName, b.ibu,(
	SELECT AVG(score)
	FROM Rating r
	WHERE r.beerId = b.id
)
AS AverageRating
FROM Beer b, Rating r, Brewery br
WHERE b.breweryId = br.id;


-- The following query shows each city in the Brewery table, and how many breweries there are in
-- that particular city. This is useful for both distributors and entrepreneurs looking to open
-- a brewery in that city. If a city is already saturated with breweries, there is no use in 
-- opening a new brewery. Additionally, distributors can get an idea of how much/what they should
-- be stocking.
SELECT DISTINCT b.city, (
	SELECT COUNT(*)
	FROM Brewery
	WHERE city = b.city
) AS Breweries
FROM Brewery b;


-- The following Query returns a listing of every brewery in the database and the average score
-- of all of its beers. This is a useful query for customers deciding what brewery is most worth
-- trying a beer from, as well as for Distributors deciding what to stock based on popularity.
SELECT DISTINCT br.name, (SELECT AVG(score)
FROM (
	SELECT DISTINCT b.name, r.score, br.name 
	FROM Rating r, Beer b, Brewery br 
	WHERE r.beerID = b.id 
	AND b.breweryId = br.id
	)
)
FROM Brewery br, Beer b;


-- This Query returns a list of all beers and where they can be purchased. This is useful for
-- developers to add functionality to their applications that allows users to find where they can
-- purchase a particular beer.
SELECT b.name, db.DistributorId 
FROM Beer b 
LEFT OUTER JOIN DistributorBeer db
ON db.beerId = b.id;


-- Lists all of the beers in the database an the average price per unit based on all of the
-- distributors prices averaged. Useful to both buyers for deciding what to purchase in terms
-- of price per beer, and for distributors to determine pricing.
SELECT b.name, AVG(db.cost) AS AvgCost
FROM Beer b LEFT JOIN DistributorBeer db
ON db.beerId = b.id
GROUP BY b.name;


-- Self JOIN of the Rating table for comparing beers that have both a professional and community
-- rating. Usefule for brewers to determine how their beer is being received and for consumers
-- to determine the usefulness of a rating.
SELECT DISTINCT r1.beerId AS "Beer", r1.score AS "Pro Rating", r2.score AS "Community Rating"
FROM Rating r1 LEFT JOIN Rating r2
ON r1.beerId = r2.beerId
WHERE r1.ratingType = 'p'
AND r2.ratingType = 'c';

-- Calculates the ratio of breweries with a parent company to that without. Useful in determining
-- the state of the industry and whether or not a brewery can be started independantly without
-- risk.
SELECT (
	SELECT COUNT(id) FROM BREWERY
	WHERE parentId IS NOT NULl
	)/
	(
	SELECT COUNT(id) FROM BREWERY
	WHERE parentId IS NULl
	)
AS Ratio
FROM Dual;