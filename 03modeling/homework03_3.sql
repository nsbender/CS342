-- Nate Bender, CS342
-- Homework03_3

DROP TABLE Part;
DROP TABLE Employee;
DROP TABLE Customer;
DROP TABLE Order;
DROP TABLE OrderPart;
DROP TABLE CustomerOrder;

CREATE TABLE Part (
  part_num integer PRIMARY KEY,
  name varchar(30),
  price decimal(19,2),
  stock_quantity integer CHECK (assets >= 0)
);

CREATE TABLE Employee (
  employee_num integer PRIMARY KEY,
  fName varchar(30),
  lName varchar(30),
  zip varchar(5)
);

CREATE TABLE Customer (
  cust_num integer PRIMARY KEY,
  fName varchar(30),
  lName varchar(30),
  zip varchar(5)
);

CREATE TABLE Order (
  order_num integer PRIMARY KEY,
  cust_num integer,
  receipt_date date,
  expect_date date,
  actual_date date,
  FOREIGN KEY (cust_num) REFERENCES Customer(cust_num) ON DELETE SET NULL
  /* Just a note: I considered setting cascading this when the customer
   * is deleted, but I figured a company might want to keep orders even
   * if the customer is no longer in the database...
   */
);

CREATE TABLE OrderPart (
  order_num integer,
  part_num integer,
  quantity integer,
  FOREIGN KEY (order_num) REFERENCES Order(order_num) ON DELETE CASCADE,
  FOREIGN KEY(part_num) REFERENCES Part(part_num) ON DELETE SET NULL
);

CREATE TABLE CustomerOrder (
  cust_num integer,
  order_num integer,
  employee_num integer,
  FOREIGN KEY (cust_num) REFERENCES Customer(cust_num) ON DELETE SET NULL,
  FOREIGN KEY (order_num) REFERENCES Order(order_num) ON DELETE CASCADE,
  FOREIGN KEY (employee_num) REFERENCES Employee(employee_num) ON DELETE SET NULL
)

-- Sample records --

INSERT INTO Employee (1, 'Nate', 'Bender', 48085);
INSERT INTO Employee (2, 'Javin', 'Unger', 49546);
INSERT INTO Employee (3, 'Jahn', 'Davis', 49545);

INSERT INTO Customer (1, 'Keith', 'VanderLinden', 49567);
INSERT INTO Customer (2, 'Vic', 'Norman', 49546);
INSERT INTO Customer (3, 'Joel', 'Adams', 45890);

INSERT INTO Part (1, 'Cisco Catalyst 3850', 18);
INSERT INTO Part (1, 'HP Proliant DL380 G6', 50);

INSERT INTO Order (1, 2, DATE '2009-05-17', DATE '2009-05-21', DATE '2009-05-20');
INSERT INTO Order (2, 3, DATE '2010-06-18', DATE '2010-06-22', DATE '2010-06-21');

INSERT INTO OrderPart (1, 1, 3);
INSERT INTO OrderPart (2, 2, 10);

INSERT INTO CustomerOrder(1,1,3);
INSERT INTO CustomerOrder(2,2,1);
