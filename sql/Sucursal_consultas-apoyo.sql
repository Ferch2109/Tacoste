--Fer <3 :P

/*Telefonos de la sucursal*/
select * from sucursal natural join telefono_sucursal;

--dir = "calle num, del ,col,cp municipio,estado"
select id_sucursal,calle||' '||numero||', '||colonia||', '||cp||' '||municipio||', '||estado as direccion, hora_inicio,hora_cierre from informacion_sucursal order by id_sucursal;

/*Telefonos sucursal con su gerente*/
(select * from (select id_sucursal,"1" as tel1,"2" as tel2,"3" as tel3 from (select * from (select * from telefono_sucursal) natural join (SELECT id_sucursal, telefono, ROW_NUMBER() OVER (PARTITION BY id_sucursal ORDER BY id_sucursal) AS tel FROM telefono_sucursal) )
pivot ( sum(telefono) for tel in (1,2,3) ) order by id_sucursal) natural join 
(select * from gerencia_sucursal natural join (select curp, nombre||' '||paterno||' '||materno as gerente from empleado))) order by id_sucursal;

/*Info sucursal*/
select id_sucursal,gerente,direccion,tel1,tel2,tel3 from 
(select * from (select id_sucursal,"1" as tel1,"2" as tel2,"3" as tel3 from (select * from (select * from telefono_sucursal) natural join (SELECT id_sucursal, telefono, ROW_NUMBER() OVER (PARTITION BY id_sucursal ORDER BY id_sucursal) AS tel FROM telefono_sucursal) )
pivot ( sum(telefono) for tel in (1,2,3) ) order by id_sucursal) natural join 
(select * from gerencia_sucursal natural join (select curp, nombre||' '||paterno||' '||materno as gerente from empleado)))
natural join
(select id_sucursal,calle||' '||numero||', '||colonia||', '||cp||' '||municipio||', '||estado as direccion, hora_inicio,hora_cierre from informacion_sucursal) order by id_sucursal;



(select * from (select id_sucursal,"1" as tel1,"2" as tel2,"3" as tel3 from (select * from (select * from telefono_sucursal) natural join (SELECT id_sucursal, telefono, ROW_NUMBER() OVER (PARTITION BY id_sucursal ORDER BY id_sucursal) AS tel FROM telefono_sucursal) )
pivot ( sum(telefono) for tel in (1,2,3) ) order by id_sucursal) natural join 
(select * from gerencia_sucursal natural join (select curp, nombre||' '||paterno||' '||materno as gerente from empleado)));

/*CURP,ID_SUCURSAL,NOMBRECOMPLETO_GERENTE*/
select * from gerencia_sucursal natural join (select curp, nombre||' '||paterno||' '||materno as nombre_empleado from empleado); 

/*Tabla con los telefonos de las sucursales*/
select id_sucursal,"1" as tel1,"2" as tel2,"3" as tel3 from (select * from (select * from telefono_sucursal) natural join (SELECT id_sucursal, telefono, ROW_NUMBER() OVER (PARTITION BY id_sucursal ORDER BY id_sucursal) AS tel FROM telefono_sucursal) )
pivot ( sum(telefono) for tel in (1,2,3) ) order by id_sucursal;
