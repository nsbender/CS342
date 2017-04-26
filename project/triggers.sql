-- Specific beers can come in multiple quantities (e.g. 4,6,12,18,30), and
-- each of these quantities can be stocked by distributors as separate
-- rows in the DistributorBeer table. This procedure checks that there are
-- not multiple costs associated with one quantity of a particular beer at
-- a particular distributor.

CREATE OR REPLACE TRIGGER CheckDistribution
BEFORE INSERT OR UPDATE on DistributorBeer FOR EACH ROW
DECLARE
	currentCost NUMBER DEFAULT 0;
	currentUnitSize INTEGER DEFAULT 0;
BEGIN
	SELECT cost FROM DistributorBeer into currentCost
		WHERE beerId = :new.beerId
		AND distributorId = :new.distributorId;
	SELECT unitSize FROM DistributorBeer into currentUnitSize;
		WHERE beerId = :new.beerId
		AND distributorId = :new.distributorId;

	IF currentUnitSize = :new.unitSize;
		raise_application_error(-75, 'A beer in this quantity already exists from this distributor at a different price! Update that record instead');
	END IF;
END;