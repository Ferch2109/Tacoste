CREATE TABLE sucursal (
    id_sucursal INTEGER

);

ALTER TABLE sucursal ADD CONSTRAINT pk_id_sucursal PRIMARY KEY(id_sucursal);


CREATE TABLE fecha_sucursal (
    id_sucursal INTEGER,
    curp_gerente VARCHAR(25) NOT NULL,
    fecha_inicio DATE
);

ALTER TABLE fecha_sucursal ADD CONSTRAINT fk_id_sucursal FOREIGN KEY (id_sucursal) REFERENCES sucursal(id_sucursal);
ALTER TABLE fecha_sucursal ADD CONSTRAINT fk_curp_gerente FOREIGN KEY (curp_gerente) REFERENCES empleado(curp_gerente);

CREATE TABLE ubicacion_sucursal (
    id_sucursal INTEGER,
    estado VARCHAR(25) NOT NULL,
    municipio VARCHAR(25) NOT NULL,
    colonia VARCHAR(25) NOT NULL,
    cp VARCHAR(25) NOT NULL,
    calle VARCHAR(25) NOT NULL,
    numero INTEGER
);

CREATE TABLE horario_sucursal (
    id_sucursal INTEGER,
    hora_apertura INTEGER,
    hora_cierre INTEGER
);

ALTER TABLE horario_sucursal ADD CONSTRAINT fk_id_sucursal3 FOREIGN KEY (id_sucursal) REFERENCES sucursal(id_sucursal);


CREATE TABLE producto (
    id_producto INTEGER,
    nombre VARCHAR(25) NOT NULL,
    precio INTEGER
);

ALTER TABLE PRODUCTO ADD CONSTRAINT pk_id_PRODUCTO PRIMARY KEY(id_producto);

CREATE TABLE cat_producto (
    id_producto INTEGER,
    categoria VARCHAR(25)
);

ALTER TABLE cat_producto ADD CONSTRAINT fk_id_producto FOREIGN KEY (id_producto) REFERENCES producto(id_producto);

CREATE TABLE comensal (
    id_comensal INTEGER
);

ALTER TABLE comensal ADD CONSTRAINT pk_id_comensal PRIMARY KEY(id_comensal);

CREATE TABLE datos_comensal (
    id_comensal INTEGER,
    paterno VARCHAR(25) NOT NULL,
    materno VARCHAR(25) NOT NULL,
    nombre VARCHAR(25) NOT NULL,
    correo VARCHAR(25) NOT NULL,
    telefono INTEGER
);

ALTER TABLE datos_comensal ADD CONSTRAINT fk_id_comensal FOREIGN KEY (id_comensal) REFERENCES comensal(id_comensal);

CREATE TABLE direccion_comensal (
    id_comensal INTEGER,
    estado VARCHAR(25) NOT NULL,
    municipio VARCHAR(25) NOT NULL,
    colonia VARCHAR(25) NOT NULL,
    cp INTEGER,
    numero_comensal INTEGER
);

ALTER TABLE direccion_comensal ADD CONSTRAINT fk_id_comensal2 FOREIGN KEY (id_comensal) REFERENCES comensal(id_comensal);

CREATE TABLE mesa (
    no_producto INTEGER,
    id_comensal INTEGER,
    id_paymaster INTEGER
);

ALTER TABLE mesa ADD CONSTRAINT pk_no_producto PRIMARY KEY(no_producto);
ALTER TABLE mesa ADD CONSTRAINT fk_id_comensal3 FOREIGN KEY (id_comensal) REFERENCES comensal(id_comensal);


CREATE TABLE consumir (
    id_comensal INTEGER,
    id_producto INTEGER,
    ticket INTEGER
);

ALTER TABLE consumir ADD CONSTRAINT fk_id_comensal4 FOREIGN KEY (id_comensal) REFERENCES comensal(id_comensal);
ALTER TABLE consumir ADD CONSTRAINT fk_id_producto2 FOREIGN KEY (id_producto) REFERENCES producto(id_producto);

CREATE TABLE salsa (
    id_producto INTEGER,
    nombre VARCHAR(25)NOT NULL,
    nivel_picor INTEGER
);

ALTER TABLE salsa ADD CONSTRAINT fk_id_producto3 FOREIGN KEY (id_producto) REFERENCES producto(id_producto);

CREATE TABLE presentaciones (
    id_producto INTEGER,
    presentacion VARCHAR(25) NOT NULL

);

ALTER TABLE presentaciones ADD CONSTRAINT fk_id_producto4 FOREIGN KEY (id_producto) REFERENCES producto(id_producto);

CREATE TABLE inventario (
    no_lote INTEGER,
    dia VARCHAR(25),
    cantidad integer
);

ALTER TABLE inventario ADD CONSTRAINT pk_no_lote PRIMARY KEY(no_lote);

CREATE TABLE contener (
    id_producto INTEGER,
    no_producto INTEGER,
    cantidad INTEGER
);

ALTER TABLE contener ADD CONSTRAINT fk_id_producto5 FOREIGN KEY (id_producto) REFERENCES producto(id_producto);
