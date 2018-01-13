select * from proveedor;
select * from IDENTIFICACION_PROVEEDOR;

select * from DATOS_PROVEEDOR;

select rfc,calle||' '||numero||', '||colonia||', '||cp||' '||municipio||', '||estado as direccion from datos_proveedor order by rfc;

select * from IDENTIFICACION_PROVEEDOR natural join (select rfc,calle||' '||numero||', '||colonia||', '||cp||' '||municipio||', '||estado as direccion from datos_proveedor order by rfc);