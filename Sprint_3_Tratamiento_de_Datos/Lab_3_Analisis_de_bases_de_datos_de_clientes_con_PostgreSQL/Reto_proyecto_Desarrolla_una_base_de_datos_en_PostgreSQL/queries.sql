-- Escribir una consulta para contar la cantidad total de interacciones por cliente.
SELECT client_name, COUNT(interaction_id) total_interacciones
    FROM clients c
        JOIN interactions i ON c.client_id = i.client_id
GROUP BY client_name;

-- Escribir una consulta para sumar el total de ventas por cliente y por industria.
SELECT c.industry, c.client_name, SUM(s.sale_amount) AS total_ventas
		FROM sales s
		    JOIN clients c ON s.client_id = c.client_id
GROUP BY c.client_id, c.client_name, c.industry
ORDER BY c.industry, c.client_id;

-- Escribir una consulta para listar todas las interacciones y ventas para un cliente específico (utilizar subqueries si es necesario).
WITH  interacciones_cte AS (
		SELECT client_id, date AS fecha, 'Interacción' AS tipo, interaction_type AS detalle
				FROM interactions
), ventas_cte AS (
		SELECT client_id, sale_date AS fecha, 'Venta' AS tipo, CONCAT('Monto: $', sale_amount) AS detalle
				FROM sales
)
	
SELECT tipo, fecha, detalle 
    FROM interacciones_cte
WHERE client_id = 5

UNION ALL

SELECT tipo, fecha, detalle
    FROM ventas_cte
WHERE client_id = 5
ORDER BY fecha;

-- Escribir una consulta para determinar el promedio mensual de ventas y compararlo con el mes anterior (utilizar funciones de ventana).
WITH  promedio_mensual AS (
		SELECT DATE_TRUNC('month', sale_date) AS mes, ROUND(AVG(sale_amount), 2) AS promedio
				FROM sales
		GROUP BY DATE_TRUNC('month', sale_date)
)
	
SELECT mes, promedio, LAG(promedio) OVER (ORDER BY mes) AS promedio_mes_anterior, ROUND(promedio - LAG(promedio) OVER (ORDER BY mes), 2) AS diferencia
		FROM promedio_mensual;

-- Utilizar JOINs para combinar datos de clients, interactions, y sales y mostrar un resumen completo de la actividad del cliente.
SELECT c.client_id, c.client_name, c.industry, SUM(s.sale_amount) AS ventas_totales, i.interaction_type, COUNT(i.interaction_id) AS nro_interacciones
    FROM clients c
        LEFT JOIN interactions i ON c.client_id = i.client_id
        LEFT JOIN sales s ON c.client_id = s.client_id
GROUP BY c.client_id, c.client_name, c.industry, i.interaction_type
ORDER BY c.client_id;

SELECT c.client_id, c.client_name, c.industry, i.date AS fecha_interaccion, i.interaction_type, s.sale_date, s.sale_amount
    FROM clients c
        LEFT JOIN interactions i ON c.client_id = i.client_id
        LEFT JOIN sales s ON c.client_id = s.client_id
ORDER BY c.client_id, fecha_interaccion NULLS LAST, s.sale_date NULLS LAST;
