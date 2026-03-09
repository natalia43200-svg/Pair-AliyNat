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
        
	-- Ahora nos piden una lista con cada tipo de producto que se han vendido, 
    -- sus categorías, nombre de la categoría y el nombre del producto, 
    -- y el total de dinero por el que se ha vendido cada tipo de producto (teniendo en cuenta los descuentos).
     -- USAR 3 JOINS
     
SELECT c.CategoryID,c.CategoryName,p.ProductName,SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)) AS total
FROM categories AS c
INNER JOIN products AS p
    ON c.CategoryID = p.CategoryID
INNER JOIN orderdetails AS od
    ON p.ProductID = od.ProductID
INNER JOIN orders AS o
    ON od.OrderID = o.OrderID
GROUP BY 
    c.CategoryID,
    c.CategoryName,
    p.ProductName
ORDER BY total DESC;
    
SELECT c.CategoryID, c.CategoryName, p.ProductName, -- LO ESTAMOS RESOLVIENDO CON 2 JOINS
SUM(od.Quantity * od.UnitPrice * (1 - od.Discount)) AS TotalSales 
 FROM categories AS c INNER JOIN products AS p ON c.CategoryID = p.CategoryID 
 INNER JOIN orderdetails AS od -- Conectamos productos con sus detalles de venta 
 ON p.ProductID = od.ProductID GROUP BY c.CategoryID, c.CategoryName, p.ProductName;
	
    
-- El equipo de marketing necesita una lista con todas las categorías de productos, 
-- incluso si no tienen productos asociados. Queremos obtener el nombre de la categoría y el nombre 
-- de los productos dentro de cada categoría. Podriamos usar un RIGTH JOIN con 'categories'?, 
-- usemos tambien la tabla 'products'.

SELECT c.CategoryName, p.ProductName, c.Description
FROM products AS p
RIGHT JOIN categories AS c
    ON p.CategoryID = c.CategoryID;

-- Desde el equipo de ventas nos piden obtener una lista de todos los pedidos junto
-- con los datos de las empresas clientes. Sin embargo, hay algunos pedidos que pueden 
-- no tener un cliente asignado. Necesitamos asegurarnos de incluir todos los pedidos, 
-- incluso si no tienen cliente registrado.

SELECT o.OrderID, o.CustomerID, c.CompanyName
	FROM orders as o
    LEFT JOIN customers AS c
    ON o.CustomerID = c.CustomerID
    ORDER BY o.OrderID;

-- El equipo de Recursos Humanos quiere saber qué empleadas han gestionado pedidos y cuáles no. 
-- Queremos obtener una lista con todas las empleadas y, si han gestionado pedidos,
--  mostrar los detalles del pedido.
SELECT e.FirstName, e.LastName, e.EmployeeID, o.OrderID
	FROM employees AS e
    LEFT JOIN orders AS o
    ON e.EmployeeID = o.EmployeeID
    ORDER BY o.OrderID

   
    
    SELECT country, "cliente" AS relacion
	FROM customers
UNION ALL
SELECT country, "oficina" 
	FROM offices;