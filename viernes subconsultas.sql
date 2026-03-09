USE northwind;

-- Extraed información de los productos "Beverages"
-- En este caso nuestro jefe nos pide que le devolvamos toda la información 
-- necesaria para identificar un tipo de producto. En concreto, tienen especial interés por 
-- los productos con categoría "Beverages". Devuelve el ID del producto, el nombre del producto y su ID de categoría.

SELECT ProductID, ProductName, CategoryID
	FROM products
    WHERE CategoryID = (SELECT CategoryID
						FROM categories
						WHERE CategoryName = 'Beverages');
    
-- Extraed la lista de países donde viven los clientes, pero no hay ningún proveedor ubicado en ese país
-- Suponemos que si se trata de ofrecer un mejor tiempo de entrega a los clientes, 
-- entonces podría dirigirse a estos países para buscar proveedores adicionales.

SELECT DISTINCT c.Country
				FROM customers AS c
				WHERE c.Country NOT IN(SELECT DISTINCT s.Country
                FROM suppliers AS s);

-- Extraed los pedidos con el máximo "order_date" para cada empleado.
-- Nuestro jefe quiere saber la fecha de los pedidos más recientes que ha gestionado cada empleado. 
-- Para eso nos pide que lo hagamos con una query correlacionada.

SELECT *
	FROM orders as o
    WHERE order_date = (SELECT MAX(order_date)
						FROM orders as o
                        WHERE o.EmployeeID = EmployeeID);
                        
SELECT o.OrderID,o.CustomerID,o.EmployeeID,o.OrderDate,o.RequiredDate
						FROM orders AS o
						WHERE OrderDate = (SELECT MAX(OrderDate)
						FROM orders
                        WHERE o.EmployeeID = EmployeeID);
                        
-- Extraer los clientes que compraron mas de 20 artículos "Grandma's Boysenberry Spread"
-- Extraed el OrderId y el nombre del cliente que pidieron más de 20 artículos del producto 
-- "Grandma's Boysenberry Spread" (ProductID 6) en un solo pedido.

SELECT o.OrderID, o.CustomerID
	FROM orders as o
    JOIN orderdetails AS od ON o.orderID
    WHERE od.ProductID = 6
    AND od.quantity > 20;
    
SELECT o.OrderID, o.CustomerID
	FROM orders as o
    WHERE o.OrderID IN (SELECT od.OrderId -- hay que poner el IN,si ponemos = le decimos que nos de un unico valor solo
    FROM orderdetails as od
    INNER JOIN products ON products.ProductID = od.ProductID
    WHERE ProductName = "Grandma's Boysenberry Spread"
    AND od.quantity > 20);
    
    -- BONUS--
    -- Qué producto es más popular: 
    -- Extraed cuál es el producto que más ha sido comprado y la cantidad que se compró.
    SELECT ProductID, SUM(Quantity) 
		FROM orderdetails
        GROUP BY ProductID
        LIMIT 1;