CREATE OR REPLACE TRIGGER taquero_mucho
AFTER INSERT ON pedido
FOR EACH ROW
BEGIN
    UPDATE datos_comensal SET puntos = puntos + (.10* :new.total)
    WHERE datos_comensal.id_comensal = :new.id_comensal;
END;

CREATE TABLE Historico (
    Nombre VARCHAR(100),
    Precio_Nuevo INTEGER,
    Precio_Anterior INTEGER,
    Fecha_Cambio DATE,
    CONSTRAINT PK_Historico PRIMARY KEY (Nombre, Precio_Anterior)
);

CREATE OR REPLACE TRIGGER registro_historico
AFTER INSERT OR UPDATE ON producto
FOR EACH ROW
BEGIN
    if inserting then
        insert into Historico values(:new.nombre, :new.precio, 0, current_date);
    elsif updating then
        insert into Historico values(:old.nombre, :new.precio,
:old.precio, current_date);
    end if;
end;

CREATE OR REPLACE function saca_cuenta(pedido_dado varchar) return
INTEGER is total INTEGER;
BEGIN
        select sum(precio) into total from (producto NATURAL JOIN pedido)
        where no_pedido = pedido.no_pedido;
END;


CREATE OR REPLACE TRIGGER bono_empleado
AFTER INSERT ON empleado
FOR EACH ROW
BEGIN
    if MOD((current_date - :new.fecha_ingreso),5) = 0 then
        DBMS_OUTPUT.put_line ('El empleado '||:new.curp||' merece un bono');
    end if;
END;

CREATE OR REPLACE TRIGGER promociones
AFTER INSERT ON pedido
FOR EACH ROW
DECLARE
    precio INTEGER;
    cantidad INTEGER;
BEGIN
    if (EXTRACT (DAY FROM :new.fecha)) = 4 then
        select precio into precio from producto where lower(nombre) = 'pozole';
        select cantidad into cantidad from contener natural join
producto where lower(nombre) = 'pozole';
        update pedido set total = total - ((cantidad - 1)*precio)
where no_pedido = :new.no_pedido;
    elsif (EXTRACT (DAY FROM :new.fecha)) = 5 then
        select precio into precio from producto where lower(nombre)
like '%taco%';
        select cantidad into cantidad from contener natural join
producto where lower(nombre) like '%taco%';
        update pedido set total = total - ((cantidad / 2) * precio)
where no_pedido = :new.no_pedido;
    elsif (EXTRACT (DAY FROM :new.fecha)) = 2 then
        select precio into precio from producto where lower(nombre)
like '%torta%';
        select cantidad into cantidad from contener natural join
producto where lower(nombre) like '%torta%';
        update pedido set total = total - ((cantidad / 2) * precio)
where no_pedido = :new.no_pedido;
        select precio into precio from producto where lower(nombre)
like '%hamburguesa%';
        select cantidad into cantidad from contener natural join
producto where lower(nombre) like '%hamburguesa%';
        update pedido set total = total - ((cantidad / 2) * precio)
where no_pedido = :new.no_pedido;
    end if;
END;

------MENÚ----
create or replace trigger categorias
after insert or update of nombre,id_producto on producto
for each row
declare 
        nom varchar2(20);
begin  
        nom := :new.nombre;
        if nom in ('Nopal asado','Frijoles refritos','Frijoles refritos con chorizo','Don totopo','Don totopo especial','Cebollitas al carbon','Papas a la francesa','Guacamole','Chicharron de queso','Los sopecitos','Entrada') then
            insert into categoria_producto(id_producto,categoria) values(:new.id_producto, 'Entradas');
        elsif nom in ('Sopa de fideos','Sopa de hongos','Frijoles charros','Consome','Sopa azteca','Arroz a la mexicana','Arroz con mole','Arroz con huevo','Pozole rojo','Pozole blanco') then
                insert into categoria_producto(id_producto,categoria) values(:new.id_producto, 'Del Cazo');
        elsif nom in ('Sencillo de guisado','Pastor','Bistec','Chuleta','Chorizo','Pollo','Arrachera','Costilla') then
                insert into categoria_producto(id_producto,categoria) values(:new.id_producto, 'Sopes y Huaraches');
        elsif nom in ('Verdes','Rojas','Enfrijoladas','Con salsa guajillo con mole') then
                insert into categoria_producto(id_producto,categoria) values(:new.id_producto, 'Enchiladas');
        elsif nom in ('Fundido natural','Choriqueso','Chicharron de queso') then
                insert into categoria_producto(id_producto,categoria) values(:new.id_producto, 'Quesos');
        elsif nom in ('Gringa','Gringa consentida','Gringa vaquera','Gringa loca','Quesadilla tradicional','Quesadilla','Quesadilla especial','Volcanes','Volcanes con carne') then
                insert into categoria_producto(id_producto,categoria) values(:new.id_producto, 'Gringas, Quecas y Volcanes');        
        elsif nom in ('De pastor','Vegerariano','De bistec','De chuleta o pollo','De arrachera','De costilla') then
                insert into categoria_producto(id_producto,categoria) values(:new.id_producto, 'Alambres');
        elsif nom in ('Ensalada','De la granja') then
                insert into categoria_producto(id_producto,categoria) values(:new.id_producto, 'Ensaladas');
        elsif nom in ('El de pastor (2x1)','Los de guisado','El de Bistec','El de Chuleta','El de Pechuga de pollo','El de Pastor de pollo','El de Chorizo','El de Arrachera','El de Costilla') then
                insert into categoria_producto(id_producto,categoria) values(:new.id_producto, 'Tacos');
        elsif nom in ('100% Pastor','100% Carne de res','100% Pechuga de pollo','100% Arrachera') then
                insert into categoria_producto(id_producto,categoria) values(:new.id_producto, 'Hamburguesas');
        elsif nom in ('Torta pastor','Torta bistec','Torta milanesa','Torta arrachera','Torta pollo') then
                insert into categoria_producto(id_producto,categoria) values(:new.id_producto, 'Tortas');
        elsif nom in ('Jarras de agua','Aguas frescas','Refrescos','Jugo de naranja','Naranjada','Cervezas','Micheladas','Cubanas','Cafe americano','Cafe de olla','Cafe capuchino','Chocolate con leche','Te','Cafe con leche','Vaso de leche') then
                insert into categoria_producto(id_producto,categoria) values(:new.id_producto, 'Bebidas');
        elsif nom in ('Flan','Pastel') then
                insert into categoria_producto(id_producto,categoria) values(:new.id_producto, 'Postres');
        else
          insert into categoria_producto(id_producto,categoria) values(:new.id_producto, 'Salsas');
    end if;
end;        
