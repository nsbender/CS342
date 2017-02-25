-- Nate Bender, CS342
-- Homework03_3

DROP TABLE Part;
DROP TABLE Employee;
DROP TABLE Customer;
DROP TABLE Order;
DROP TABLE OrderPart;
DROP TABLE CustomerOrder;

CREATE TABLE Part (
  part_num integer PRIMARY KEY;
  name varchar(30);
  price decimal(19,2);
  stock_quantity integer CHECK (assets >= 0);
)

CREATE TABLE Employee (
  employee_num integer PRIMARY KEY;
  fName varchar(30);
  lName varchar(30);
  zip varchar(5);
)

CREATE TABLE Customer (
  cust_num integer PRIMARY KEY;
  fName varchar(30);
  lName varchar(30);
  zip varchar(5);
)

CREATE TABLE Order (

)
