-- Task 1 creazione database--
CREATE DATABASE ToysGroup;
USE ToysGroup;

-- Task 2 creazione Tabelle--

-- Creazione tabella categoria--
CREATE TABLE Category (
    ID INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    Name VARCHAR(50) NOT NULL,
    Type VARCHAR(100)
);

-- Creazione tabella Prodotti--
CREATE TABLE Product (
    ID INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    Name VARCHAR(50) NOT NULL,
    Description VARCHAR(100),
    Sell_Price DECIMAL(10,2),
    Cost_Price DECIMAL(10,2),
    Category_ID INT,
    FOREIGN KEY (Category_ID) REFERENCES Category(ID)
);

-- Creazione tabella Regione --
CREATE TABLE Region (
    ID INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    Name VARCHAR(50) NOT NULL,
    State VARCHAR(50) NOT NULL
);

-- Creazione tabella Clienti--
CREATE TABLE Costumer (
    ID INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    First_Name VARCHAR(50) NOT NULL,
    Last_Name VARCHAR(50) NOT NULL,
    Email VARCHAR(150) NOT NULL,
    Phone_Number VARCHAR(20),
    Address VARCHAR(100),
    City VARCHAR(50),
    Postal_Code VARCHAR(20),
    Country VARCHAR(50),
    Region_ID INT,
    FOREIGN KEY (Region_ID) REFERENCES Region(ID)
);

-- Creazione tabella Vendite --
CREATE TABLE Sales (
    ID INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    Order_Number VARCHAR(50) NOT NULL,
    Order_Date DATE NOT NULL,
    Order_Quantity SMALLINT NOT NULL,
    Unit_Price DECIMAL(10,2),
    Total_Cost DECIMAL(10,2),
    Product_ID INT,
    Region_ID INT,
    Costumer_ID INT,
    FOREIGN KEY (Product_ID) REFERENCES Product(ID),
    FOREIGN KEY (Region_ID) REFERENCES Region(ID),
    FOREIGN KEY (Costumer_ID) REFERENCES Costumer(ID)
);



ALTER TABLE Region
ADD Geographic_Region VARCHAR(50) NOT NULL;

-- Task 3 popola le tabelle --

INSERT INTO Category (Name, Type) VALUES
('Electronics', 'Gadgets and devices'),
('Books', 'Literature and novels'),
('Clothing', 'Apparel and accessories'),
('Food', 'Groceries and edibles'),
('Furniture', 'Home and office furnishings'),
('Toys', 'Children’s entertainment'),
('Sports Equipment', 'Athletic gear and accessories'),
('Health & Beauty', 'Personal care products'),
('Automotive', 'Vehicle parts and accessories'),
('Pet Supplies', 'Products for pets and animals');

INSERT INTO Product (Name, Description, Sell_Price, Cost_Price, Category_ID) VALUES
('Smartphone', 'Latest model with advanced features', 699.99, 550.00, 1),
('Laptop', 'Lightweight and powerful', 1199.99, 950.00, 1),
('Mystery Novel', 'A thrilling mystery book', 15.99, 10.00, 2),
('Winter Jacket', 'Warm and cozy for winter', 99.99, 60.00, 3),
('Organic Apples', 'Fresh and delicious', 3.49, 2.00, 4),
('Office Desk', 'Spacious and stylish', 149.99, 100.00, 5),
('Action Figure', 'Popular superhero toy', 19.99, 12.00, 6),
('Tennis Racket', 'High-performance sports gear', 79.99, 50.00, 7),
('Shampoo', 'Gentle and nourishing', 8.99, 5.00, 8),
('Car Battery', 'Long-lasting and reliable', 89.99, 70.00, 9),
('Dog Food', 'Nutritious and tasty', 24.99, 15.00, 10);


INSERT INTO Region (Name, State, Geographic_Region) VALUES
('Lazio', 'Italy', 'Southern Europe'),
('Bavaria', 'Germany', 'Central Europe'),
('Catalonia', 'Spain', 'Southern Europe'),
('Île-de-France', 'France', 'Western Europe'),
('Andalusia', 'Spain', 'Southern Europe'),
('Lombardy', 'Italy', 'Southern Europe'),
('Scotland', 'United Kingdom', 'Northern Europe'),
('Occitanie', 'France', 'Western Europe'),
('Tuscany', 'Italy', 'Southern Europe'),
('Bavaria', 'Germany', 'Central Europe');

INSERT INTO Sales (Order_Number, Order_Date, Order_Quantity, Unit_Price, Total_Cost, Product_ID, Region_ID) VALUES
('ORD001', '2025-01-10', 10, 79.99, 799.90, 1, 1),
('ORD002', '2025-01-11', 5, 15.99, 79.95, 3, 2),
('ORD003', '2025-01-12', 20, 3.49, 69.80, 5, 3),
('ORD004', '2025-01-13', 3, 149.99, 449.97, 6, 4),
('ORD005', '2025-01-14', 12, 8.99, 107.88, 9, 5),
('ORD006', '2025-01-15', 7, 99.99, 699.93, 4, 6),
('ORD007', '2025-01-16', 15, 19.99, 299.85, 7, 7),
('ORD008', '2025-01-17', 8, 89.99, 719.92, 10, 8),
('ORD009', '2025-01-18', 6, 1199.99, 7199.94, 2, 9),
('ORD010', '2025-01-19', 10, 24.99, 249.90, 11, 10),
('ORD011', '2024-08-15', 8, 89.99, 719.92, 10, 8),
('ORD012', '2024-07-20', 5, 24.99, 124.95, 11, 9),
('ORD013', '2024-06-25', 10, 79.99, 799.90, 1, 1),
('ORD014', '2024-05-30', 15, 19.99, 299.85, 7, 7),
('ORD015', '2024-04-10', 6, 1199.99, 7199.94, 2, 9),
('ORD016', '2024-02-23', 4, 49.99, 199.96, 1, 2),
('ORD017', '2024-01-15', 12, 25.99, 311.88, 3, 5),
('ORD018', '2024-03-10', 7, 99.99, 699.93, 4, 6),
('ORD019', '2023-12-05', 10, 199.99, 1999.90, 2, 9),
('ORD020', '2023-11-25', 15, 15.99, 239.85, 6, 4);

INSERT INTO Costumer (First_Name, Last_Name, Email, Phone_Number, Address, City, Postal_Code, Country, Region_ID) VALUES
('Mario', 'Rossi', 'mario.rossi@example.com', '1234567890', 'Via Roma 1', 'Roma', '00100', 'Italy', 1),
('Anna', 'Bianchi', 'anna.bianchi@example.com', '2345678901', 'Corso Italia 2', 'Milano', '20100', 'Italy', 6),
('John', 'Doe', 'john.doe@example.com', '3456789012', 'Baker Street 221B', 'London', 'NW1', 'United Kingdom', 7),
('Jane', 'Smith', 'jane.smith@example.com', '4567890123', 'Champs-Élysées 3', 'Paris', '75008', 'France', 8),
('Maria', 'Garcia', 'maria.garcia@example.com', '5678901234', 'La Rambla 4', 'Barcelona', '08002', 'Spain', 3),
('Giovanni', 'Verdi', 'giovanni.verdi@example.com', '6789012345', 'Via Napoli 5', 'Napoli', '80100', 'Italy', 9),
('Paul', 'Brown', 'paul.brown@example.com', '7890123456', 'Rue de Rivoli 6', 'Paris', '75001', 'France', 4),
('Linda', 'Taylor', 'linda.taylor@example.com', '8901234567', 'Via Garibaldi 7', 'Torino', '10100', 'Italy', 10),
('Sara', 'Martinez', 'sara.martinez@example.com', '9012345678', 'Gran Vía 8', 'Madrid', '28013', 'Spain', 5),
('Peter', 'Wilson', 'peter.wilson@example.com', '0123456789', 'Oxford Street 9', 'London', 'W1D', 'United Kingdom', 7);

ALTER TABLE Costumer
DROP COLUMN Country; -- pensando che potesse essere rindondante perchè presente in due tabelle l'ho eliminato --