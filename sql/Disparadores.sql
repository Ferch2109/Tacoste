CREATE OR REPLACE TRIGGER taquero_mucho
AFTER INSERT ON pedido
FOR EACH ROW
BEGIN
    update comensal SET puntos = puntos + (.10 * :new.total) 
    WHERE no_pedido = :new.pedido;
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
        insert into Historico values(:old.nombre, :new.precio, :old.precio, current_date);
    end if;
end;    

CREATE OR REPLACE function saca_cuenta(pedido_dado varchar) return INTEGER is total INTEGER;
BEGIN
        select sum(precio) into total from (producto NATURAL JOIN pedido) 
        where id_pedido = pedido.id_pedido;
END;

CREATE OR REPLACE TRIGGER promociones
AFTER INSERT ON pedido
DECLARE 
    precio_promo INTEGER;
    cantidad INTEGER;
BEGIN
    if EXTRACT(DAY FROM :new.fecha) = 4 then 
        select precio into precio_promo from producto
        where lower(nombre) = 'pozole';
        select cantidad into cantidad from contener natural join producto
        where no_pedido = :new.no_pedido and lower(nombre) = 'pozole';
        update pedido set total = total - (cantidad * precio_promo) 
        where no_pedido = :new.no_pedido; 
    elsif EXTRACT(DAY FROM :new.fecha) = 5 then
        select precio into precio_promo from producto
        where lower(nombre) like ('%taco%');
        select cantidad into cantidad from contener NATURAL JOIN producto
        where no_pedido = :new.no_pedido and nombre like ('%taco%');
        update pedido set total = total - (cantidad * (precio_promo / 2))
        where no_pedido = :new.no_pedido;
    elsif EXTRACT(DAY FROM :new.fecha) = 2 then
        select precio into  precio_promo from producto
        where lower(nombre) like ('%torta%');
        select cantidad into cantidad from contener NATURAL JOIN producto
        where no_pedido = :new.no_pedido and lower(nombre) like ('%torta%');
        update pedido set total = total - (cantidad * (precio_promo / 2))
        where no_pedido = :new.no_pedido;
        select precio into precio_promo from producto
        where lower(nombre) like ('%hamburguesa%');
        select cantidad into cantidad from contener natural join producto
        where no_pedido = :new.no_pedido and lower(nombre) like ('%hamburguesa%');
        update pedido set total = total - (cantidad * (precio_promo / 2));
    end if;
END;

        