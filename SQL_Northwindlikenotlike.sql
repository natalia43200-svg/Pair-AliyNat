USE northwind;
-- Ciudades que empiezan con "A" o "B".

SELECT c.City as 'ciudad', c.CompanyName as 'compañías', c.ContactName as 'Nombre Cliente'
	FROM customers as c
	WHERE c.city LIKE "A%" OR c.city LIKE "B%";
    
-- Número de pedidos que han hecho en las ciudades que empiezan con L.

SELECT c.City as 'ciudad', c.CompanyName as 'compañías', c.ContactName as 'Nombre Cliente', COUNT(o.orderID) AS total_pedidos
	FROM customers as c
		INNER JOIN orders as o 
        ON o.CustomerID = c.CustomerID
        WHERE c.City LIKE "L%"
        GROUP BY c.City, c.CompanyName, c.ContactName;
     
     -- Todos los clientes cuyo "country" no incluya "Sales".
     SELECT c.ContactName, c.ContactTitle, c.CompanyName
     FROM customers as c
     WHERE c.ContactTitle NOT LIKE "%Sales%";
     
   SELECT c.ContactName
     FROM customers as c
     WHERE c.ContactName NOT LIKE "_A%";
     
SELECT c.City, c.CompanyName, c.ContactName, "Customers" AS Relationship

-- Extraer todas las categorías de la tabla categories que contengan en la descripción "sweet" o "Sweet".


	FROM customers as c
UNION 
SELECT s.City, s.CompanyName, s.ContactName, "Suppliers" AS Relationship
	FROM suppliers as s
    ORDER BY City;
    
    SELECT cat.CategoryName, cat.Description
    FROM categories as cat
	WHERE cat.Description LIKE "%Sweet%" OR cat.Description LIKE "%sweet%";
    
    SELECT CONCAT(e.FirstName," ", e.LastName) AS Nombre_Completo
	FROM employees as e
    UNION 
    SELECT CONCAT(c.ContactName) AS Nombre_Completo
    FROM customers as c;