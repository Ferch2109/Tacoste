select * from comensal;

select * from datos_comensal;

--nombre y id
select id_comensal,nombre||' '||paterno||' '||materno as nombre from comensal;

--dir = "calle num, del ,col,cp municipio,estado"
select id_comensal,calle||' '||numero||', '||colonia||', '||cp||' '||municipio||', '||estado as direccion,telefono,correo,puntos from datos_comensal order by id_comensal;


/*Info comensal*/
select * from (select id_comensal,nombre||' '||paterno||' '||materno as nombre from comensal) 
              natural join 
              (select id_comensal,calle||' '||numero||', '||colonia||', '||cp||' '||municipio||', '||estado as direccion,correo,telefono,puntos from datos_comensal)
order by id_comensal;