-- Comensales que todavia no han consumido (nombre completo).
SELECT  c.paterno, c.materno, c.nombre
FROM comensal c, consumir cs,
WHERE c.id_comensal = cs.id_comensal AND
      NOT EXISTS (SELECT * FROM consumir WHERE c.id_comensal = consumir.id_comensal);


--Comensales que ya han consumido (Nombre completo)*/
 SELECT c.paterno, c.materno, c.nombre
 FROM comensal c, datos_comensal cs
 WHERE c.id_comensal = cs.id_comensal AND
      EXISTS (SELECT * FROM  WHERE c.id_comensal = consumir.id_comensal);

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
