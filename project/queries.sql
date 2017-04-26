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





