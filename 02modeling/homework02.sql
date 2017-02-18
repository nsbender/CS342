/*
 * Nate Bender
 * CS342
 * Homework02
*/

--- Problem 1 ---

-- Initialize the database by clearing existing data
DROP TABLE Custmer;
DROP TABLE Order;
DROP TABLE OrderItem;
DROP TABLE Item;
DROP TABLE Shipment;
DROP TABLE Warehouse;

-- Create the CUSTOMER table and specify the customer_number as the primary key,
-- and disallow any fields to be NULL
CREATE TABLE Customer(
	customer_number integer NOT NULL,
	customer_name varchar(32) NOT NULL,
	city varchar(32) NOT NULL,
	PRIMARY KEY (customer_number)
);

-- Create the Order table and specify order_number as the primary key
CREATE TABLE Order(
	order_number integer,
	customer_number integer,
	order_date date NOT NULL,
	order_amount integer ,
	PRIMARY KEY (order_number),
	FOREIGN KEY (customer_number) REFERENCES Customer(customer_number) ON DELETE SET NULL,
	CHECK (order_amount > 0)
);

-- Create the OrderItem table and set its Foreign keys and no Primary
-- since it only exists as a joint table
CREATE TABLE OrderItem(
	order_number integer,
	item_num integer,
	quantity integer,
	FOREIGN KEY (order_number) REFERENCES Order(order_number) ON DELETE SET NULL,
	FOREIGN KEY (item_number) REFERENCES Item(item_number) ON DELETE SET NULL,
	CHECK (quantity > 0)
);

-- Create the Item table and make item_number Primary. It doesn't need to reference
-- any other tables, but it's Primary key can't be NULL
CREATE TABLE Item(
  	item_number integer NOT NULL,
  	item_name varchar(16) NOT NULL,
  	price Decimal(19,2), -- A pretty standard number format for storing dollar amounts
  	PRIMARY KEY (item_number),
  	CHECK (price > 0)
  );

-- Create the Shipment table and specify its order_number and warehouse_numer as
-- foreign keys. It needs no Primary since the order_number shouldn't be repeated.
CREATE TABLE Shipment(
	order_number integer,
	warehouse_number integer,
	ship_date date NOT NULL,
	FOREIGN KEY (order_number) REFERENCES Order(order_number) ON DELETE SET NULL,
	FOREIGN KEY (warehouse_number) REFERENCES Warehouse(warehouse_number) ON DELETE SET NULL
);

-- Create the Warehouse table and give it a Primary id number.
CREATE TABLE Warehouse(
	warehouse_number integer NOT NULL,
	city varchar(32) NOT NULL,
	PRIMARY KEY (warehouse_num)
);

--- Sample Data ---

-- Setup the sequences for creating the sample entries
CREATE SEQUENCE customer_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE order_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE item_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE warehouse_seq START WITH 1 INCREMENT BY 1;

INSERT INTO Customer VALUES (customer_seq.nextVal, 'Nate Bender', 'Troy');
INSERT INTO Customer VALUES (customer_seq.nextVal, 'David Michel', 'Chicago');
INSERT INTO Customer VALUES (customer_seq.nextVal, 'Mark Davis', 'Grand Rapids');

INSERT INTO Item VALUES (item_seq.nextVal, 'Widget', 150.00);
INSERT INTO Item VALUES (item_seq.nextVal, 'Gadget', 300.00);
INSERT INTO Item VALUES (item_seq.nextVal, 'Doodad', 200.00);
INSERT INTO Item VALUES (item_seq.nextVal, 'Whatsit', 5000.00);

INSERT INTO Warehouse VALUES (warehouse_seq.nextVal, 'Detroit');
INSERT INTO Warehouse VALUES (warehouse_seq.nextVal, 'Kansas City');
INSERT INTO Warehouse VALUES (warehouse_seq.nextVal, 'New York');

INSERT INTO Order VALUES (order_seq.nextVal, 1, sysdate, 20);
INSERT INTO Order VALUES (order_seq.nextVal, 2, sysdate, 50);
INSERT INTO Order VALUES (order_seq.nextVal, 3, sysdate, 100);

INSERT INTO OrderItem VALUES (1, 1, 1);
INSERT INTO OrderItem VALUES (2, 3, 2);
INSERT INTO OrderItem VALUES (3, 2, 1);

INSERT INTO Shipment VALUES (1, 1, sysdate); -- Ships immediately, but oh well.
INSERT INTO Shipment VALUES (2, 3, sysdate); -- I guess we're just that good.
INSERT INTO Shipment VALUES (3, 1, sysdate);


--- Problem 2 ---

/*
Surrogate keys are perfectly acceptable in this type of system. In fact, this is the *ideal* system
for them to be used. They aren't connected to any other piece of data that could potentially change in the
future such as a username (nsb2, kvlinden, etc.). Another unique piece of student data could be used, such as
a social security number, but not only is that insecure but also esentially just another kind of surrogate.
*/

--- Problem 3 ---

-- All orders from Nate along with date, and amount. Ordered by date
SELECT Order.order_date, Order.order_amount FROM Order -- and join it with the Customer
JOIN Customer ON Order.customer_number = Customer.customer_nuber -- when the order cust_id matches the cust_id
WHERE Customer.customer_name = 'Nate Bender'
ORDER BY Order.order_date;  -- the sort it by date

-- All the customer ID numbers for customers who have at least one order in the database
SELECT UNIQUE Customer.customer_number FROM Customer
-- Where the Order and Customer tables overlap
INNER JOIN Order On Customer.customer_number = Order.customer_number;

-- The customer IDs and names of the people who have ordered a 'Widget'
SELECT Customer.customer_number, Customer.customer_name FROM Customer
JOIN Order ON Customer.customer_number = Ord.customer_number
JOIN OrderItem ON Order.order_number = OrderItem.order_number
JOIN Item ON Ordertem.item_number = Item.item_number
WHERE Item.item_name = 'Widget';
