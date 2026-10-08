-- ============================================================
-- MiniStore - Soluciones con OUTER JOINs
-- Autor: David
-- Fecha: 2026-10-08
-- ============================================================

-- CONSULTA 1: LEFT JOIN
-- Muestra todo el catalogo y las ventas asociadas.
-- Los productos 108 y 109 aparecen con NULL porque nunca se vendieron.
SELECT
    p.producto_id,
    p.nombre,
    p.categoria,
    v.venta_id,
    v.cliente_id,
    v.cantidad,
    v.fecha_venta
FROM productos AS p
LEFT JOIN ventas AS v
    ON p.producto_id = v.producto_id
ORDER BY p.producto_id, v.venta_id;

-- Filtro opcional para ver solamente los productos nunca vendidos:
-- WHERE v.venta_id IS NULL


-- CONSULTA 2: RIGHT JOIN
-- Conserva todas las ventas, aunque el producto no exista en el catalogo.
-- La venta 10, asociada al producto 999, aparece con datos del catalogo en NULL.
SELECT
    v.venta_id,
    v.producto_id AS producto_vendido_id,
    p.producto_id AS producto_catalogo_id,
    p.nombre,
    p.categoria,
    v.cliente_id,
    v.cantidad,
    v.fecha_venta
FROM productos AS p
RIGHT JOIN ventas AS v
    ON p.producto_id = v.producto_id
ORDER BY v.venta_id;

-- Filtro opcional para ver solamente las ventas huerfanas:
-- WHERE p.producto_id IS NULL


-- CONSULTA 3: FULL OUTER JOIN
-- Auditoria completa: no pierde productos ni ventas de ninguna tabla.
SELECT
    p.producto_id AS producto_catalogo_id,
    v.producto_id AS producto_vendido_id,
    p.nombre,
    p.categoria,
    v.venta_id,
    v.cliente_id,
    v.cantidad,
    v.fecha_venta,
    CASE
        WHEN v.venta_id IS NULL THEN 'Producto sin ventas'
        WHEN p.producto_id IS NULL THEN 'Venta sin producto en catalogo'
        ELSE 'Coincidencia correcta'
    END AS estado_auditoria
FROM productos AS p
FULL OUTER JOIN ventas AS v
    ON p.producto_id = v.producto_id
ORDER BY COALESCE(p.producto_id, v.producto_id), v.venta_id;
