CREATE TABLE Beer(
  id integer PRIMARY KEY,
  name varchar(64),
  breweryId integer REFERENCES Brewery(id),
  variety varchar(32),
  ibu integer,
  current boolean,
  introduced date,
  abv decimal(4,2)
);

CREATE TABLE Brewery(
  id integer PRIMARY KEY,
  name varchar(64),
  yearFounded intege,
  country varchar(32),
  city varchar(32),
  parentId integer REFERENCES ParentCompany(id),
  website varchar(128)
);

CREATE TABLE ParentCompany(
  id integer PRIMARY KEY,
  name varchar(64),
  country varchar(32)
);

CREATE TABLE Distributor(
  id integer PRIMARY KEY,
  name varchar(64),
  address varchar(128)
);

CREATE TABLE Ingredient(
  id integer PRIMARY KEY,
  type varchar(32), -- Hops, Malt, Grain, etc
  name varchar(64)
);

CREATE TABLE Rating(
  beerId integer REFERENCES Beer(id) ON DELETE CASCADE,
  score numeric, -- 0 to 100
  type varchar(1), -- c for community scores, p for professional critic scores
  source varchar(64)
);

CREATE TABLE DistributorBeer(
  distributorId integer REFERENCES Distributor(id) ON DELETE CASCADE,
  beerId integer REFERENCES Beer(id) ON DELETE CASCADE,
  unitSize integer, -- 6 for six-pack, 12 for twelve-pack, etc
  cost numeric
);

CREATE TABLE BeerIngredient(
  beerId integer REFERENCES Beer(id) ON DELETE CASCADE,
  IngredientId integer REFERENCES Ingredient(id) ON DELETE CASCADE,
);
