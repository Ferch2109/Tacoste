select * from empleado;

select * from telefono_empleado;

/*Info licencia*/
select curp,tipo,vigencia,transporte from repartidor natural join datos_licencia;

--nombre
select curp,rfc,nombre||' '||paterno||' '||materno as nombre, sueldo from empleado;

--dir = "col,cp municipio,estado"
select curp,colonia||', '||cp||' '||municipio||', '||estado as direccion from datos_empleado order by curp;

/*Telefonos empleado*/
select curp,"1" as tel1,"2" as tel2,"3" as tel3 from (select * from (select * from telefono_empleado) natural join (SELECT curp, telefono_empleado, ROW_NUMBER() OVER (PARTITION BY curp ORDER BY curp) AS tel FROM telefono_empleado) )
pivot ( sum(telefono_empleado) for tel in (1,2,3) ) order by curp;


/*Info empleado sin repartidores: rfc,nombre,dir,sueldo,telefonos*/
select rfc,nombre,direccion,sueldo,tel1,tel2,tel3 
from (select * from (select curp,rfc,nombre||' '||paterno||' '||materno as nombre, sueldo from empleado) 
                    natural join 
                    (select curp,colonia||', '||cp||' '||municipio||', '||estado as direccion from datos_empleado))
      natural join (select curp,"1" as tel1,"2" as tel2,"3" as tel3 from (select * from (select * from telefono_empleado) natural join (SELECT curp, telefono_empleado, ROW_NUMBER() OVER (PARTITION BY curp ORDER BY curp) AS tel FROM telefono_empleado) )
pivot ( sum(telefono_empleado) for tel in (1,2,3) ))
order by nombre;


/*Info empleados*/
select * from (select *
                from (select * from (select curp,rfc,nombre||' '||paterno||' '||materno as nombre, sueldo from empleado) 
                                    natural join 
                                    (select curp,colonia||', '||cp||' '||municipio||', '||estado as direccion from datos_empleado))
                      natural join (select curp,"1" as tel1,"2" as tel2,"3" as tel3 from (select * from (select * from telefono_empleado) natural join (SELECT curp, telefono_empleado, ROW_NUMBER() OVER (PARTITION BY curp ORDER BY curp) AS tel FROM telefono_empleado) )
                pivot ( sum(telefono_empleado) for tel in (1,2,3) )))
                natural join
                (select curp,tipo,vigencia,transporte from repartidor natural join datos_licencia)
order by nombre;
