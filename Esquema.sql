--Tablas Fong

CREATE TABLE comensal(
    id_comensal VARCHAR(20),
    paterno VARCHAR(30),
    materno VARCHAR(30),
    nombre VARCHAR(50),
    correo VARCHAR(100) CHECK (Correo IN ('%@%.%'))
);



CREATE TABLE datos_comensal(
    id_comensal VARCHAR(20),
    estado VARCHAR(30),
    municipio VARCHAR(50),
    colonia VARCHAR(50),
    cp INTEGER,
    numero INTEGER,
    correo VARCHAR(100) CHECK (Correo IN ('%@%.%')),
    telefono INTEGER,
    puntos INTEGER
    
);



CREATE TABLE pedido(
    no_pedido INTEGER,
    id_comensal VARCHAR(20),
    fecha DATE,
    forma_pago VARCHAR(20)
    
);


CREATE TABLE mesa (
    id_mesa VARCHAR(20),
    id_comensal VARCHAR(20),
    id_paymaster VARCHAR(20)
    
);



CREATE TABLE producto(
    id_producto VARCHAR(20) ,
    nombre VARCHAR(20),
    precio INTEGER

);




CREATE TABLE contener (
    no_pedido INTEGER,
    id_producto VARCHAR(20),
    cantidad INTEGER
);


CREATE TABLE categoria_producto (
    id_producto VARCHAR(20),
    categoria VARCHAR(20)
    
);


CREATE TABLE ingrediente (
    nombre_ingrediente VARCHAR(20) 
);




CREATE TABLE participar(
    id_producto VARCHAR(20),
    nombre_ingrediente VARCHAR(20)
);



CREATE TABLE consumir (
    id_comensal VARCHAR(20),
    id_pedido VARCHAR(20),
    ticket INTEGER
    
);



CREATE TABLE etiqueta_producto (
    id_producto VARCHAR(20),
    etiqueta VARCHAR(20)
    
);

ALTER TABLE etiqueta_producto ADD CONSTRAINT fk_id_producto_3 FOREIGN KEY (id_producto) REFERENCES producto(id_producto);



CREATE TABLE salsa (
    id_producto VARCHAR(20),
    id_salsa VARCHAR(20)
    nombre VARCHAR(20),
    nivel_picor INTEGER
);


CREATE TABLE presentacion_salsa (
    id_producto VARCHAR(20),
    presentacion VARCHAR(20)
    
);



CREATE TABLE emparejar (
    id_salsa VARCHAR(20),
    id_producto VARCHAR (20),
    
);






--Tablas Quiños

CREATE TABLE sucursal (
    id_sucursal INTEGER
    
    
);

CREATE TABLE gerencia_sucursal (
    id_sucursal INTEGER,
    curp VARCHAR(25)
    
);

CREATE TABLE informacion_sucursal (
    id_sucursal INTEGER,
    estado VARCHAR(25) NOT NULL,
    municipio VARCHAR(25) NOT NULL,
    colonia VARCHAR(25) NOT NULL,
    cp INTEGER,
    calle  VARCHAR(25) NOT NULL,
    numero INTEGER,
    hora_inicio INTEGER,
    hora_cierre INTEGER
);

CREATE TABLE telefono_sucursal (
    id_sucursal INTEGER,
    telefono INTEGER
);

drop table gerencia_sucursal;

CREATE TABLE empleado (
    curp VARCHAR(25) NOT NULL,
    rfc VARCHAR (25)NOT NULL,
    paterno VARCHAR(25) NOT NULL,
    materno VARCHAR(25) NOT NULL,
    nombre VARCHAR(25) NOT NULL
);

CREATE TABLE datos_empleado (
    curp  VARCHAR(25) NOT NULL,
    estado VARCHAR(25) NOT NULL,
    municipio VARCHAR(25) NOT NULL,
    colonia VARCHAR(25) NOT NULL,
    cp VARCHAR(25) NOT NULL
);

CREATE TABLE correo_empleado (
    curp VARCHAR(25) NOT NULL,
    correo VARCHAR(25) NOT NULL
);



CREATE TABLE telefono_empleado (
    curp VARCHAR(25) NOT NULL,
    telefono_empleado INTEGER
);

CREATE TABLE supervisar (
    curp VARCHAR(25)NOT NULL
);

CREATE TABLE licencia (
    codigo INTEGER
);

CREATE TABLE licencia_repartidor(
    codigo INTEGER,
    curp VARCHAR(25) NOT NULL
);



CREATE TABLE datos_licencia (
    codigo INTEGER,
    tipo VARCHAR(25) NOT NULL,
    vigencia DATE,
    transporte VARCHAR(25) NOT NULL
);

CREATE TABLE repartidor (
    curp INTEGER,
    codigo INTEGER
);



CREATE TABLE proveedor (
    rfc VARCHAR(25) NOT NULL
);

CREATE TABLE identificacion_proveedor (
    rfc VARCHAR(25) NOT NULL,
    nombre VARCHAR(25)NOT NULL
);

CREATE TABLE datos_proveedor (
    rfc VARCHAR(25) NOT NULL,
    estado VARCHAR(25) NOT NULL,
    municipio VARCHAR(25) NOT NULL,
    colonia VARCHAR(25) NOT NULL,
    calle VARCHAR(25) NOT NULL,
    cp INTEGER,
    numero INTEGER
);

CREATE TABLE suministro (
    id_suministro INTEGER
);

CREATE TABLE nombre_suministro (
    id_suministro INTEGER,
    nombre VARCHAR(25) NOT NULL
);

CREATE TABLE datos_suministro (
    id_suministro INTEGER,
    rfc VARCHAR(25) NOT NULL,
    marca VARCHAR(25) NOT NULL,
    precio FLOAT
);

CREATE TABLE inventario (
    no_lote INTEGER,
    dia VARCHAR(25) NOT NULL,
    cantidad FLOAT
);

CREATE TABLE suministrar (
    no_lote INTEGER,
    id_suministro INTEGER
);

CREATE TABLE generar (
    id_sucursal INTEGER,
    no_lote INTEGER
);
