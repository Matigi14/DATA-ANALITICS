/*Consulta 1*/
SELECT 
    FORMAT(v.FechaVenta, 'yyyy-MM') AS PeriodoMes,
    COUNT(DISTINCT v.IDVenta) AS CantidadTransacciones,
    SUM(v.Cantidad * v.PrecioUnitario) AS FacturacionTotal,
    AVG(v.Cantidad * v.PrecioUnitario) AS TicketPromedio
FROM dbo.Ventas AS v
GROUP BY FORMAT(v.FechaVenta, 'yyyy-MM')
ORDER BY PeriodoMes;

/*Consulta 2*/

SELECT TOP 10
		    IDProducto,
            SUM(Cantidad) AS CantidadVendida,
			SUM(Cantidad*PrecioUnitario) AS TotalFacturado
FROM dbo.Ventas
GROUP BY IDProducto
ORDER BY TotalFacturado DESC;


/*Consulta 3*/
SELECT 
    c.IDCLiente,
    c.Nombre AS NombreCliente,
    COUNT(DISTINCT v.IDVenta) AS CantidadPedidos,
    SUM(v.Cantidad * v.PrecioUnitario) AS FacturacionTotal,
    AVG(v.Cantidad * v.PrecioUnitario) AS TicketPromedio
FROM Clientes AS c
INNER JOIN Ventas AS v 
    ON c.IDCLiente = v.IDCliente
GROUP BY 
    c.IDCLiente, 
    c.Nombre

HAVING COUNT(DISTINCT v.IDVenta) > 1
ORDER BY CantidadPedidos DESC;

/*Consulta 4*/
WITH VentasPorMes AS (
    SELECT 
        FORMAT(FechaVenta, 'yyyy-MM') AS Mes,
        SUM(Cantidad*PrecioUnitario) AS TotalFacturado
    FROM dbo.Ventas
    GROUP BY FORMAT(FechaVenta, 'yyyy-MM')
)
SELECT 
    Mes,
    TotalFacturado,
    CASE 
        WHEN TotalFacturado >= AVG(TotalFacturado) OVER () THEN 'Por encima'
        ELSE 'Por debajo'
    END AS EstadoVsPromedio
FROM VentasPorMes
ORDER BY Mes;




/* 1- EL PRODUCTO 1 ES EL QUE MAS FACTURO EN EL MES 3 CON UN 59% DEL TOTAL FACTURADO
   2- AUNQUE EL CLIENTE 1 HAYA REALIZADO MENOS PEDIDOS QUE LOS CLIENTES 2 Y 3, ES EL QUE MAS GASTO
   3- EL UNICO CLIENTE QUE NO HIZO MAS DE UN PEDIDO FUE EL CLIENTE 6