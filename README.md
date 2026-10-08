# MiniStore: análisis con OUTER JOINs

Este repositorio contiene una práctica de SQL para analizar el catálogo y las ventas de MiniStore mediante `LEFT JOIN`, `RIGHT JOIN` y `FULL OUTER JOIN`.

## Estructura

- `schema.sql`: crea las tablas `productos` y `ventas` y carga los datos de prueba.
- `soluciones.sql`: contiene las tres consultas solicitadas.
- `README.md`: explica las decisiones y cómo ejecutar la práctica.

## Cómo ejecutar el proyecto en pgAdmin 4

1. Abrir pgAdmin 4 y conectarse a PostgreSQL.
2. Crear o seleccionar una base de datos para la práctica.
3. Abrir **Query Tool**.
4. Abrir y ejecutar primero `schema.sql` con el botón **Execute** (▶).
5. Abrir y ejecutar después `soluciones.sql`.
6. Para revisar cada resultado por separado, seleccionar solamente una consulta y presionar **Execute**.

## Respuestas

### 1. ¿Por qué usar LEFT JOIN y no INNER JOIN?

Se usa `LEFT JOIN` porque necesitamos conservar todos los productos del catálogo, incluso cuando no tienen una venta relacionada. Un `INNER JOIN` eliminaría del resultado los productos 108 (`Hub USB-C 7p`) y 109 (`Parlante Bluetooth`) porque no tienen coincidencias en `ventas`.

### 2. ¿Por qué usar RIGHT JOIN en la Consulta 2?

La tabla `ventas` está a la derecha y debe conservarse completa para detectar operaciones cuyo producto no existe en el catálogo. Por eso, la venta 10 con `producto_id = 999` permanece en el resultado y las columnas provenientes de `productos` aparecen como `NULL`.

La misma lógica podría escribirse invirtiendo el orden de las tablas y usando `LEFT JOIN`, pero en esta práctica se utiliza `RIGHT JOIN` para demostrar su funcionamiento.

### 3. ¿Qué representan los valores NULL?

- En la Consulta 1, un `venta_id` igual a `NULL` significa que el producto existe en el catálogo, pero nunca fue vendido.
- En la Consulta 2, un `producto_catalogo_id` igual a `NULL` significa que la venta existe, pero hace referencia a un producto ausente del catálogo. Esto puede representar un error de carga o un problema de integridad de datos.

`NULL` no significa cero ni texto vacío: indica que no se encontró una fila coincidente en la otra tabla.

### 4. ¿Cuándo usar FULL OUTER JOIN en un caso real?

Se puede usar durante una auditoría o migración para comparar dos sistemas. Por ejemplo, permite encontrar productos cargados en el catálogo que nunca tuvieron movimientos y, al mismo tiempo, ventas históricas que apuntan a productos inexistentes. Así se detectan diferencias de ambos lados sin perder registros.

## Resultados esperados

- Consulta 1: aparecen los 9 productos del catálogo; los productos 108 y 109 muestran columnas de venta en `NULL`.
- Consulta 2: aparecen las 10 ventas; la venta 10 del producto 999 muestra las columnas del catálogo en `NULL`.
- Consulta 3: aparecen todas las coincidencias y también los tres casos especiales: los productos 108 y 109 sin ventas y la venta del producto 999 sin catálogo.

## Autor

David
