--TEMPORAL TABLES
USE MASTER
GO

CREATE DATABASE Temporal
GO

CREATE TABLE Inventory (
  ProductID NVARCHAR(20) PRIMARY KEY CLUSTERED, -- temporal tables must have a primary key and must be clustered
  QuantityInStock INT NOT NULL,
  QuantityReserved INT NOT NULL, 
  SysStartTime DATETIME2 GENERATED ALWAYS AS ROW START NOT NULL, --used to hold the start date/time of when the record was current
  SysEndTime DATETIME2 GENERATED ALWAYS AS ROW END NOT NULL, ----used to hold the end date/time of when the record was current 
  PERIOD FOR SYSTEM_TIME (SysStartTime, SysEndTime) --gets the date/timefrom the computer abd stores in the 2 defined columns
  )
  WITH (SYSTEM_VERSIONING = ON (HISTORY_TABLE = dbo.Inventory_History))

INSERT INTO Inventory (ProductID, QuantityInStock, QuantityReserved)
VALUES ('OilFilter1', 59, 5),
       ('OilFilter2', 23, 2), 
	    ('FuelFilter1', 120, 0),
		 ('FuelFilter2', 35, 5), 
		  ('FuelFilter3', 10, 10)


SELECT * FROM Inventory
SELECT * FROM Inventory_History

UPDATE Inventory SET QuantityInStock = 54, QuantityReserved = 0 WHERE ProductID = 'OilFilter1'
UPDATE Inventory SET QuantityInStock = 21, QuantityReserved = 0 WHERE ProductID = 'OilFilter2'

DELETE FROM Inventory WHERE ProductID LIKE 'FuelFilter%'

UPDATE Inventory SET QuantityInStock = 48, QuantityReserved = 6 WHERE ProductID = 'OilFilter1'

