-- Comensales que más han consumido (nombre completo).
select nombre||' '||paterno||' '||materno as nombre 
from comensal natural join (select id_comensal,count(id_comensal)
from consumir group by id_comensal
having count(id_comensal) = (select max(count(id_comensal)) from consumir group by id_comensal));

select id_comensal,count(id_comensal)
from consumir group by id_comensal
having count(id_comensal) = (select max(count(id_comensal)) from consumir group by id_comensal);



--Salsa más vendida (Nombre salsa,precio, numero de ventas)*/
 select * fro

--Todos los empleados que tienen como sueldo $5000 (Nombre completo)*/
 SELECT e.paterno, e.materno, e.nombre
 FROM datos_empleado JOIN ON datos_empleado.curp = empleado.curp
 WHERE empleado.sueldo = 5000;

 --Nombre completo de los empleados que son gerentes*/
SELECT e.paterno, e.materno, e.nombre
FROM empleado NATURAL JOIN (SELECT curp
                            FROM gerencia_sucursal);

--Nombre completo de las personas que son empleados excepto repartidores*/
SELECT e.paterno, e.materno, e.nombre
FROM empleado NATURAL JOIN (SELECT curp
                           FROM repartidor
                           MINUS
                           SELECT curp
                                        FROM repartidor);
--Esta consulta nos muestra con que prefieren pagar los clientes, para
--esto usamos
--tablas temporales, para almacenar cuántas veces se paga con qué
--metodo y después
--Únicamente sacar el máximo.
CREATE TABLE cuenta_veces
AS SELECT count(forma_pago) pago FROM pedido
WHERE (lower(forma_pago) = 'efectivo') OR (lower(forma_pago) = 'tarjeta')
GROUP BY forma_pago;

SELECT max(pago) as preferida FROM cuenta_veces;

--Que salsa es la que más participa en los productos que vende la taquería.
CREATE TABLE cuenta_apariciones
AS SELECT count(id_salsa) veces FROM emparejar
GROUP BY id_salsa;

SELECT * FROM salsa
WHERE id_producto = (SELECT max(veces) FROM cuenta_apariciones);

--Vamos a ver qué producto es el que piden má en cualquier sucursal.
select * from   

CREATE TABLE veces_productos
AS SELECT count(id_producto) apariciones FROM contener
GROUP BY id_producto;

SELECT nombre FROM producto
WHERE id_producto = (SELECT max(apariciones) FROM veces_productos);
