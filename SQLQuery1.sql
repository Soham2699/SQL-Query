----Mail 2: Scripting Tables-----

DROP TABLE IF EXISTS ShippingEfficiency;
DROP TABLE IF EXISTS Order_Status_Data;
DROP TABLE IF EXISTS ShippingAddress;
DROP TABLE IF EXISTS Shipment_Method_Data;
DROP TABLE IF EXISTS Customer_Order_Data;

CREATE TABLE Customer_Order_Data (
OrderID INT PRIMARY KEY,
CustomerID INT,
PaymentID INT,
OrderStatusID INT,
ShippingMethodID INT,
ShippingAddressID INT,
DatePaid DATE,
EstDateShipped DATE,
ActualDateShipped DATE,
DateModified DATE,
);

CREATE TABLE Shipment_Method_Data (
ShipmentMethodID INT PRIMARY KEY,
ShipmentMode VARCHAR(50),
ShipmentClass VARCHAR(50),
ShipmentTime VARCHAR(50),
FreightCost DECIMAL(5,2),
DateModified DATE,
);

CREATE TABLE Order_Status_Data (
OrderStatusID INT PRIMARY KEY,
Description VARCHAR(50),
DateModified DATE,
);

CREATE TABLE ShippingAddress (
ShipmentAddressID INT PRIMARY KEY,
CustomerID INT,
StreetNumber INT,
StreetName VARCHAR(25),
StreetType VARCHAR(15),
PostalCode VARCHAR(6),
City VARCHAR(20),
CountryID INT,
Notes VARCHAR(300)
);

CREATE TABLE ShippingEfficiency (
OrderID INT,
OrderStatusID INT,
ShipmentMethodID INT,
ShipmentAddressID INT,
ShippingTimeEstimationAccuracy INT,
CONSTRAINT PK_ShippingEfficiency PRIMARY KEY (OrderID, ShipmentMethodID, ShipmentAddressID, OrderStatusID),
CONSTRAINT FK_ShippingEfficiency_Order FOREIGN KEY (OrderID) REFERENCES Customer_Order_Data(OrderID) ON UPDATE NO ACTION ON DELETE NO ACTION,
CONSTRAINT FK_ShippingEfficiency_OrderStatus FOREIGN KEY (OrderStatusID) REFERENCES Order_Status_Data(OrderStatusID) ON UPDATE NO ACTION ON DELETE NO ACTION,
CONSTRAINT FK_ShippingEfficiency_ShipmentMethod FOREIGN KEY (ShipmentMethodID) REFERENCES Shipment_Method_Data(ShipmentMethodID) ON UPDATE NO ACTION ON DELETE NO ACTION,
CONSTRAINT FK_ShippingEfficiency_ShippingAddress FOREIGN KEY (ShipmentAddressID) REFERENCES ShippingAddress(ShipmentAddressID) ON UPDATE NO ACTION ON DELETE NO ACTION,
);




----Mail 4: Inserting Sample Data-

INSERT INTO Customer_Order_Data(OrderID,CustomerID,PaymentID,OrderStatusID,ShippingMethodID,ShippingAddressID,DatePaid,EstDateShipped,ActualDateShipped,DateModified)
VALUES
  (1000,2000,1,10,1,100,'2022-06-21','2023-05-04','2023-05-07','2022-12-21'),
  (1001,2001,2,11,6,101,'2020-09-13','2021-01-18','2021-01-18','2023-12-13'),
  (1002,2002,3,12,11,102,'2021-01-21','2022-12-26','2022-12-23','2027-01-21'),
  (1003,2003,4,13,16,103,'2023-09-18','2023-10-13','2023-10-17','2022-10-18'),
  (1004,2004,5,14,21,104,'2022-11-11','2023-12-03','2023-04-23','2022-10-11');

INSERT INTO Shipment_Method_Data (ShipmentMethodID,ShipmentMode,ShipmentClass,ShipmentTime,FreightCost,DateModified)
VALUES
  (1000,'On Air','One-Day','10:10AM',497.98,'2022-08-18'),
  (1001,'On Air','Normal','2:10PM',167.64,'2023-01-24'),
  (1002,'On-Road','One-Day','1:01AM',189.24,'2024-01-27'),
  (1003,'On Rails','Normal','6:42PM',114.32,'2023-07-20'),
  (1004,'On Rails','Urgent','2:57PM',106.18,'2022-11-26');

INSERT INTO Order_Status_Data (OrderStatusID,Description,DateModified)
VALUES
  (1000,'No problems','2023-05-26'),
  (1001,'minor Delays,Reached','2021-06-02'),
  (1002,'minor Delays,Reached','2022-11-27'),
  (1003,'major Delays,Reached','2024-12-10'),
  (1004,'Lost','2022-11-01');

INSERT INTO ShippingAddress (ShipmentAddressID,CustomerID,StreetNumber,StreetName,StreetType,PostalCode,city,CountryID,Notes)
VALUES
  (1000,100,42,'Ap #161-445 Fergus. Av.','Business','B0V8W7','Whitehorse',223,'Be Cautious while handling the product'),
  (1001,101,197,'808-2222 fergus','Business','Y2N44J','BlackHorse',153,'Good quality packaging'),
  (1002,102,30,'Ap #110-3658 Weber Ave','Business','36H6L6','Montague',15,'Good quality packaging, Fragile. Be Cautious while handling the product'),
  (1003,103,196,'Ap #477-515 Grulke.','Industrial','S6YZS9','Ranch',20,'Low quality packaging, Fragile. Be Cautious while handling the product and add extra layer of packaging for protection'),
  (1004,104,261,'800-2241 Lathi Rd.','Residential','Y3J2P7','Rome',83,'Low quality packaging, Fragile. Be Cautious while handling the product and add extra layer of packaging for protection');

INSERT INTO ShippingEfficiency (OrderID, OrderStatusID, ShipmentMethodID,ShipmentAddressID, ShippingTimeEstimationAccuracy)
VALUES
  (1000,1000,1000,1000,1),
  (1001,1001,1001,1001,2),
  (1002,1002,1002,1002,3),
  (1003,1003,1003,1003,4),
  (1004,1004,1004,1004,0);