-- Assignment by Zaid Ahmed Khan Seat Number B23110106082


CREATE DATABASE CarShowroomDB;

CREATE TABLE Customers(
    CustomerID SERIAL PRIMARY KEY,
    CustomerName VARCHAR(100),
    City VARCHAR(50),
    State VARCHAR(50),
    JoinDate DATE
);

CREATE TABLE Cars(
    CarID SERIAL PRIMARY KEY,
    Model VARCHAR(100),
    Brand VARCHAR(50),
    Year INT,
    Price NUMERIC(12,2),
    Color VARCHAR(30),
    InventoryCount INT
);

CREATE TABLE Salespersons(
    SalespersonID SERIAL PRIMARY KEY,
    Name VARCHAR(100),
    Department VARCHAR(50),
    HireDate DATE
);

CREATE TABLE Sales(
    SaleID SERIAL PRIMARY KEY,
    CustomerID INT REFERENCES Customers(CustomerID),
    CarID INT REFERENCES Cars(CarID),
    SaleDate DATE,
    SalePrice NUMERIC(12,2),
    SalespersonID INT REFERENCES Salespersons(SalespersonID)
);

CREATE TABLE ServiceRecords(
    RecordID SERIAL PRIMARY KEY,
    CarID INT REFERENCES Cars(CarID),
    ServiceDate DATE,
    ServiceType VARCHAR(50),
    Cost NUMERIC(10,2),
    TechnicianID INT
);


-- Customers
INSERT INTO Customers(CustomerName, City, State, JoinDate) VALUES
('Ali Raza', 'Lahore', 'Punjab', '2021-02-15'),
('Sara Khan', 'Karachi', 'Sindh', '2020-05-10'),
('Usman Tariq', 'Islamabad', 'Capital', '2022-08-22'),
('Hira Malik', 'Faisalabad', 'Punjab', '2019-11-05'),
('Bilal Qureshi', 'Multan', 'Punjab', '2023-03-18'),
('Nida Iqbal', 'Quetta', 'Balochistan', '2021-09-12'),
('Zain Abbas', 'Hyderabad', 'Sindh', '2022-01-25'),
('Fatima Noor', 'Rawalpindi', 'Punjab', '2020-07-09');

-- Cars
INSERT INTO Cars(Model, Brand, Year, Price, Color, InventoryCount) VALUES
('Civic Turbo', 'Honda', 2023, 58000, 'White', 5),
('City Aspire', 'Honda', 2022, 35000, 'Black', 3),
('Corolla Altis', 'Toyota', 2023, 40000, 'Silver', 4),
('Fortuner Legender', 'Toyota', 2022, 80000, 'White', 2),
('Sportage AWD', 'Kia', 2023, 45000, 'Blue', 6),
('Sorento Premium', 'Kia', 2021, 60000, 'Gray', 1),
('Elantra GLS', 'Hyundai', 2022, 37000, 'Red', 3),
('Tucson Ultimate', 'Hyundai', 2023, 50000, 'Black', 2),
('Mustang GT', 'Ford', 2021, 90000, 'Yellow', 1),
('F-150 Raptor', 'Ford', 2023, 95000, 'Black', 2);

-- Salespersons
INSERT INTO Salespersons(Name, Department, HireDate) VALUES
('Ahmed Raza', 'SUV Sales', '2018-04-10'),
('Sana Malik', 'Sedan Sales', '2019-07-12'),
('Omar Shah', 'Luxury Sales', '2020-03-05'),
('Hassan Ali', 'SUV Sales', '2021-09-15');

-- Sales
INSERT INTO Sales(CustomerID, CarID, SaleDate, SalePrice, SalespersonID) VALUES
(1, 1, '2023-04-12', 57000, 2),
(2, 4, '2022-12-08', 79000, 1),
(3, 5, '2023-06-21', 44500, 1),
(4, 9, '2021-11-02', 88000, 3),
(5, 2, '2023-07-18', 34000, 2),
(6, 3, '2022-02-25', 39500, 2),
(7, 7, '2023-08-05', 36500, 4),
(8, 10, '2023-05-14', 94000, 3),
(2, 6, '2022-09-09', 59000, 1),
(1, 8, '2023-10-22', 49500, 4),
(3, 1, '2023-11-15', 58000, 2),
(4, 4, '2022-06-30', 80000, 1);

-- ServiceRecords
INSERT INTO ServiceRecords(CarID, ServiceDate, ServiceType, Cost, TechnicianID) VALUES
(1, '2023-06-12', 'Oil Change', 150, 101),
(2, '2023-07-19', 'Tire Replacement', 800, 102),
(3, '2023-08-05', 'Brake Service', 550, 103),
(4, '2022-11-02', 'Engine Overhaul', 2500, 104),
(5, '2023-09-09', 'Battery Replacement', 400, 105),
(6, '2022-10-15', 'Oil Change', 120, 101),
(7, '2023-12-01', 'Transmission Repair', 1800, 106),
(8, '2023-12-15', 'Brake Service', 600, 103),
(9, '2023-07-25', 'Paint Job', 1500, 107),
(10, '2023-05-10', 'Engine Overhaul', 2700, 104);

-- Part 1: Basic Aggregate Functions

-- Total number of customers
SELECT COUNT(*) AS TotalCustomers FROM Customers;

-- Average sale price of all car sales
SELECT AVG(SalePrice) AS AverageSalePrice FROM Sales;

-- Most expensive car ever sold
SELECT MAX(SalePrice) AS MaxSalePrice FROM Sales;

-- Total inventory count of all cars
SELECT SUM(InventoryCount) AS TotalInventory FROM Cars;

-- Earliest and most recent sale dates
SELECT MIN(SaleDate) AS EarliestSale, MAX(SaleDate) AS LatestSale FROM Sales;

-- Part 2: GROUP BY Exercises

-- Count models per brand
SELECT Brand, COUNT(*) AS ModelCount
FROM Cars
GROUP BY Brand;

-- Total sales amount for each salesperson
SELECT s.SalespersonID, sp.Name, SUM(s.SalePrice) AS TotalSales
FROM Sales s
JOIN Salespersons sp ON s.SalespersonID = sp.SalespersonID
GROUP BY s.SalespersonID, sp.Name;

-- Average sale price for each car model
SELECT c.Model, AVG(s.SalePrice) AS AvgSalePrice
FROM Sales s
JOIN Cars c ON s.CarID = c.CarID
GROUP BY c.Model;

-- Average service cost per service type
SELECT ServiceType, AVG(Cost) AS AvgServiceCost
FROM ServiceRecords
GROUP BY ServiceType;

-- Count of cars by brand and color
SELECT Brand, Color, COUNT(*) AS CarCount
FROM Cars
GROUP BY Brand, Color;

-- Clause Exercises

-- Brands with more than 5 models
SELECT Brand, COUNT(*) AS ModelCount
FROM Cars
GROUP BY Brand
HAVING COUNT(*) > 5;

-- Models sold more than 10 times
SELECT c.Model, COUNT(*) AS SaleCount
FROM Sales s
JOIN Cars c ON s.CarID = c.CarID
GROUP BY c.Model
HAVING COUNT(*) > 10;

-- Salespersons with avg sale price > 50000
SELECT sp.Name, AVG(s.SalePrice) AS AvgSalePrice
FROM Sales s
JOIN Salespersons sp ON s.SalespersonID = sp.SalespersonID
GROUP BY sp.Name
HAVING AVG(s.SalePrice) > 50000;

-- Months with more than 20 sales
SELECT EXTRACT(MONTH FROM SaleDate) AS SaleMonth, COUNT(*) AS SaleCount
FROM Sales
GROUP BY EXTRACT(MONTH FROM SaleDate)
HAVING COUNT(*) > 20;

-- Service types with avg cost > 500
SELECT ServiceType, AVG(Cost) AS AvgCost
FROM ServiceRecords
GROUP BY ServiceType
HAVING AVG(Cost) > 500;
