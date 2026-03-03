USE northwind;

-- Nos piden el ID del cliente y el nombre de la empresa y el número de pedidos.

SELECT c.CompanyName AS NombreEmpresa, c.CustomerID AS Identificador, c.Country, COUNT(o.OrderID) AS NumeroPedidos
	FROM customers as c
	INNER JOIN orders AS o
    ON c.CustomerID = o.CustomerID
    WHERE c.Country = "UK"
    GROUP BY c.CompanyName, c.CustomerID;
    
    SELECT c.CompanyName AS NombreEmpresa, YEAR(o.OrderDate), SUM(od.Quantity), c.Country
		FROM customers as c
		INNER JOIN orders AS o
		ON c.CustomerID = o.CustomerID
        INNER JOIN orderdetails as od
        ON o.OrderID = od.OrderID
        WHERE c.Country = "UK"
		GROUP BY c.CompanyName, o.OrderDate;
    
     SELECT o.OrderID, c.CompanyName, o.OrderDate
		FROM customers as c
		INNER JOIN orders AS o
		ON c.CustomerID = o.CustomerID
		GROUP BY o.OrderID, c.CompanyName, o.OrderDate;
        
	
        
