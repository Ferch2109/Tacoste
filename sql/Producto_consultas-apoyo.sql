select * from producto;

select * from categoria_producto order by id_producto;

select * from emparejar;

select * from etiqueta_producto;

select * from salsa;

select id_producto,nombre,categoria,precio from producto natural join categoria_producto order by id_producto;

select * from (select * from producto natural join categoria_producto) natural join etiqueta_producto;

/*Id_prod, nombre, nivel_picor*/
select emparejar.id_producto,nombre,nivel_picor from emparejar cross join salsa order by id_producto;

select distinct * from (select * from (select * from producto natural join categoria_producto) natural join etiqueta_producto)
natural join (select emparejar.id_producto,nombre,nivel_picor from emparejar cross join salsa);