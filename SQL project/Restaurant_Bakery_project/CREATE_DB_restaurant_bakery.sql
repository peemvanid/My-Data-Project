--create_table_calories

CREATE TABLE IF NOT EXISTS calories (
    cal_id INT NOT NULL PRIMARY KEY
    , menu_id INT
    , kcal REAL
    , FOREIGN KEY (menu_id) REFERENCES menu(menu_id)
);

INSERT INTO calories VALUES
	(1, 1, 610)
    ,(2, 2, 750)
    ,(3, 3, 600)
    ,(4, 4, 970)
    ,(5, 5, 900)
    ,(6, 6, 420)
    ,(7, 7, 770)
    ,(8, 8, 1020)
    ,(9, 9, 600)
    ,(10, 10, 650)
    ,(11, 11, 620)
    ,(12, 12, 630)
    ,(13, 13, 630)
    ,(14, 14, 515)
    ,(15, 15, 32)
    ,(16, 16, 0)
    ,(17, 17, 92)
    ,(18, 18, 28)
    ,(19, 19, 41)
    ,(20, 20, 0)
    ;
------------------------------------------------------------------------------------------------

--create_table_customers

CREATE TABLE IF NOT EXISTS customers (
  customer_id INTERGER NOT NULL PRIMARY KEY
  , Firstname TEXT 
  , Lastname TEXT
  , Gender TEXT
  , DoB TEXT
  , Phone INT
  );
  
INSERT INTO customers VALUES
	(1, 'Jennifer', 'Sure', 'Female', '1980-07-12', 12345)
	, (2, 'Marie', 'Scott', 'Female', '1982-11-10', 23456)
    , (3, 'Auther', 'Mogany', 'Male', '1992-05-01', 34567)
    , (4, 'Dutch', 'Vander', 'Male', '1989-12-23', 45678)
    , (5, 'Javier', 'Escua', 'Female', '2003-06-09', 57890)
    , (6, 'Will', 'Other', 'Male', '2000-12-02', 67890)
    , (7, 'Jack', 'Mars', 'Male', '2012-01-07', 78912)
    , (8, 'Marry', 'Mars', 'Female', '2015-04-15', 89100)
    , (9, 'Ganny', 'Grand', 'Female', '1969-07-10', 90123)
    , (10, 'Morey', 'Anderson', 'Male', '1972-09-06', 98765)
    ;
------------------------------------------------------------------------------------------------

--create_table_invoice

CREATE TABLE IF NOT EXISTS invoice (
  invoice_id INT NOT NULL PRIMARY KEY
  , customer_id INT NOT NULL
  , invoice_date TEXT NOT NULL
  , menu_id INT NOT NULL
  , quantity INT NOT NULL
  
  , FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
  , FOREIGN KEY (menu_id) REFERENCES menu(menu_id)
  );

INSERT INTO invoice VALUES
	(1, 9, '2022-01-05 07:03:10', 1, 1)
    , (2, 2, '2022-01-05 07:20:10', 3, 2)
    , (3, 10, '2022-01-05 07:45:23', 1, 1)
    , (4, 10, '2022-01-05 07:45:23', 11, 1)
    , (5, 10, '2022-01-05 07:45:23', 16, 1)
    , (6, 7, '2022-01-05 07:47:02', 9, 1)
    , (7, 8, '2022-01-05 07:47:20', 9, 1)
    , (8, 8, '2022-01-05 07:47:20', 18, 2)
    , (9, 6, '2022-01-05 09:15:10', 8, 2)
    , (10, 1, '2022-01-05 10:10:24', 5, 1)
    , (11, 1, '2022-01-05 12:45:10', 17, 1)
    , (12, 5, '2022-01-05 13:03:10', 2, 1)
    , (13, 2, '2022-01-05 13:05:45', 13, 2)
    , (14, 3, '2022-01-05 13:20:23', 15, 2)
    , (15, 10, '2022-01-05 13:30:43', 15, 1)
    , (16, 5, '2022-01-05 13:51:00', 12, 1)
    , (17, 1, '2022-01-05 14:00:10', 15, 5)
    , (18, 2, '2022-01-05 14:13:50', 13, 2)
    , (19, 4, '2022-01-05 14:20:56', 12, 3)
    , (20, 4, '2022-01-05 14:30:17', 16, 3)
    ;
------------------------------------------------------------------------------------------------

--create_table_membership

CREATE TABLE IF NOT EXISTS membership (
  member_id TEXT NOT NULL PRIMARY KEY
  , customer_id INT
  , member_type TEXT
  , date_expired TEXT
  , FOREIGN KEY (customer_id) REFERENCES customers (customer_id)
  );
  
INSERT INTO membership VALUES
  ('A00001', 1, 'Gold Card', '2023-06-01')
  , ('A00002', 3, 'Gold Card', '2023-06-01')
  , ('A00003', 9, 'Gold Card', '2023-06-01')
  ;
------------------------------------------------------------------------------------------------

--create_table_menu

CREATE TABLE IF NOT EXISTS menu (
	menu_id INTEGER PRIMARY KEY
	, menu_name TEXT NOT NULL
	, price REAL NOT NULL);
	
INSERT INTO menu VALUES 
	(1, 'Buttermilk Pancake', 100)
	, (2, 'Buttermilk Pancake with Bacon', 120)
	, (3, 'Egg Sandwich', 80)
	, (4, 'Ham Cheese Sandwich', 95)
	, (5, 'Mix Sandwich', 100)
	, (6, 'Daily Salad', 75)
	, (7, 'Chicken Pesto', 100)
	, (8, 'Ham & Swiss Sandwich', 120)
	, (9, 'Kids Sandwich', 75)
	, (10, 'Cream Cheese Brownie', 85)
	, (11, 'Black Forrest Cake', 100)
	, (12, 'Blueberry Cheese Cake', 105)
	, (13, 'Strawberry Cheese Cake', 105)
	, (14, 'Daily Pie', 105)
	, (15, 'Coffee', 55)
    , (16, 'Tea', 50)
    , (17, 'Green Tea Macha', 65)
    , (18, 'Milk', 50)
    , (19, 'Soft Drink', 45)
    , (20, 'Mineral Water', 45)
    ;
------------------------------------------------------------------------------------------------

--create_table_set_bridge

CREATE TABLE IF NOT EXISTS set_bridge (
  set_id TEXT
  , menu_id INT
  , FOREIGN KEY (set_id) REFERENCES set_menu(set_id)
  , FOREIGN KEy (menu_id) REFERENCES menu(menu_id)
  );

INSERT INTO set_bridge VALUES
	('S01', 2)
    , ('S01', 14)
    , ('S01', 15)
    , ('S02', 7)
    , ('S02', 6)
    , ('S02', 12)
    , ('S02', 19)
    , ('S03', 13)
    , ('S03', 10)
    , ('S03', 15)
    , ('S03', 17)
    , ('S04', 1)
    , ('S04', 9)
    , ('S04', 18)
    ;
------------------------------------------------------------------------------------------------

--create_table_set_menu

CREATE TABLE IF NOT EXISTS set_menu (
  set_id TEXT NOT NULL PRIMARY KEY
  , set_name TEXT
  );
  
INSERT INTO set_menu VALUES
	('S01', 'Morning Breakfast')
    , ('S02', 'Combo Lunch')
    , ('S03', 'Lazy Afternoon Break')
    , ('S04', 'Kids Meal')
    ;
------------------------------------------------------------------------------------------------
--delete records from the table
DELETE FROM calories;
DELETE FROM customers;
DELETE FROM invoice;
DELETE FROM membership;
DELETE FROM menu;
DELETE FROM set_bridge;
DELETE FROM set_menu;

--drop tables
DROP TABLE IF EXISTS calories;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS invoice;
DROP TABLE IF EXISTS membership;
DROP TABLE IF EXISTS menu;
DROP TABLE IF EXISTS set_bridge;
DROP TABLE IF EXISTS set_menu;