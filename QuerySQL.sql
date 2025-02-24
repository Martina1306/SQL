USE Toysgroup;
--	Verificare che i campi definiti come PK siano univoci. In altre parole, scrivi una query per determinare l’univocità dei valori di ciascuna PK (una query per tabella implementata).--
-- Task 4--
SHOW KEYS FROM Category; -- la colonna Non_unique=0 indica una chiave senza dupliati quindi unica
SHOW KEYS FROM Product;
SHOW KEYS FROM Region;
SHOW KEYS FROM Sales;
SHOW KEYS FROM Costumer;

SELECT ID, COUNT(*) -- Questa query ricerca valori duplicati, se interrogata non restituisce nessun valore, vuol dire che non ci snon duplicati e che il campo è univoco
FROM Category
GROUP BY ID
HAVING COUNT(*) > 1;

SELECT ID, COUNT(*)
FROM Product
GROUP BY ID
HAVING COUNT(*) > 1;

SELECT ID, COUNT(*)
FROM Sales
GROUP BY ID
HAVING COUNT(*) > 1;

SELECT ID, COUNT(*)
FROM Region
GROUP BY ID
HAVING COUNT(*) > 1;

SELECT ID, COUNT(*)
FROM Costumer 
GROUP BY ID
HAVING COUNT(*) > 1;




-- 2 Esporre l’elenco delle transazioni indicando nel result set il codice documento, la data, il nome del prodotto, la categoria del prodotto, il nome dello stato, il nome della regione di vendita e un campo booleano valorizzato in base alla condizione che siano passati più di 180 giorni dalla data vendita o meno (>180 -> True, <= 180 -> False) --

SELECT s.Order_Date as data, s.Order_Number as codice_documento, p.Name, c.Name as categoria, r.State, r.Geographic_Region as Zone,
IF (DATEDIFF(CURRENT_DATE,s.Order_Date) >180 ,'true', 'false') as '>180gg'
FROM Category c
JOIN Product p
ON c.ID = p.Category_ID
LEFT JOIN Sales s
ON p.ID = s.Product_ID
JOIN Region r
ON r.ID = s.Region_ID
ORDER BY s.Order_Number;



-- 3 Esporre l’elenco dei prodotti che hanno venduto, in totale, una quantità maggiore della media delle vendite realizzate nell’ultimo anno censito. (ogni valore della condizione deve risultare da una query e non deve essere inserito a mano). Nel result set devono comparire solo il codice prodotto e il totale venduto. --

SELECT Product.ID AS Product_ID, SUM(Sales.Order_Quantity) AS Total_Sold
FROM Product
JOIN Sales ON Product.ID = Sales.Product_ID
WHERE YEAR(Sales.Order_Date) = (SELECT MAX(YEAR(Order_Date)) FROM Sales)
GROUP BY Product.ID
HAVING SUM(Sales.Order_Quantity) > (
    SELECT AVG(S.Order_Quantity)
    FROM Sales S
    WHERE YEAR(S.Order_Date) = (SELECT MAX(YEAR(Order_Date)) FROM Sales)
)
ORDER BY Total_Sold DESC;

-- 4 Esporre l’elenco dei soli prodotti venduti e per ognuno di questi il fatturato totale per anno -- 
SELECT Product.ID,
    YEAR(Sales.Order_Date) AS Year,
    SUM(Sales.Total_Cost) AS Total_Revenue
FROM Product
JOIN Sales ON Product.ID = Sales.Product_ID
GROUP BY Product.ID, YEAR(Sales.Order_Date)
ORDER BY Product.ID, Year;

-- 5 Esporre il fatturato totale per stato per anno. Ordina il risultato per data e per fatturato decrescente --
SELECT Region.State AS State,
    YEAR(Sales.Order_Date) AS Year,
    SUM(Sales.Total_Cost) AS Total_Revenue
FROM Sales
JOIN Region ON Sales.Region_ID = Region.ID
GROUP BY Region.State, YEAR(Sales.Order_Date)
ORDER BY YEAR(Sales.Order_Date), SUM(Sales.Total_Cost) DESC;
    
-- 6 Rispondere alla seguente domanda: qual è la categoria di articoli maggiormente richiesta dal mercato? --

SELECT Category.Name,
    SUM(Sales.Order_Quantity) AS Total_Quantity_Sold
FROM Sales
JOIN Product ON Sales.Product_ID = Product.ID
JOIN Category ON Product.Category_ID = Category.ID
GROUP BY Category.Name
ORDER BY Total_Quantity_Sold DESC;

-- 7 Rispondere alla seguente domanda: quali sono i prodotti invenduti? Proponi due approcci risolutivi differenti. --
SELECT Product.ID, Product.Name
FROM Product
LEFT JOIN Sales ON Product.ID = Sales.Product_ID
WHERE Sales.Product_ID IS NULL;

SELECT Product.ID, Product.Name 
FROM Product 
WHERE Product.ID NOT IN (
    SELECT Sales.Product_ID 
    FROM Sales
);


-- 8 Creare una vista sui prodotti in modo tale da esporre una “versione denormalizzata” delle informazioni utili (codice prodotto, nome prodotto, nome categoria)--
CREATE VIEW ProductView AS
SELECT Product.ID AS Product_ID,Product.Name AS Product_Name,Category.Name AS Category_Name
FROM Product
JOIN Category ON Product.Category_ID = Category.ID;
    
    -- 9 Creare una vista per le informazioni geografiche--
    CREATE VIEW GeographicInfo AS
SELECT Region.ID AS ID,Region.Name AS Name,Region.State AS State,Region.Geographic_Region AS Area
FROM Region;

