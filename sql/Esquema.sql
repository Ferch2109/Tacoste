--Tablas Fong

CREATE TABLE Comensal(
    Id_Comensal VARCHAR(20) PRIMARY KEY,
    Paterno VARCHAR(30),
    Materno VARCHAR(30),
    Nombre VARCHAR(50),
    Correo VARCHAR(100) CHECK (Correo IN ('%@%.%'))
);

CREATE TABLE DatosComensal(
    Id_Comensal VARCHAR(20) PRIMARY KEY,
    Estado VARCHAR(30),
    Municipio VARCHAR(50),
    Colonia VARCHAR(50),
    CP INTEGER,
    Numero INTEGER,
    Correo VARCHAR(100) CHECK (Correo IN ('%@%.%')),
    Telefono INTEGER,
    Puntos INTEGER,
    FOREIGN KEY (Id_Comensal) REFERENCES Comensal(Id_Comensal)
);

CREATE TABLE Pedido(
    No_Pedido INTEGER PRIMARY KEY,
    Id_Comensal VARCHAR(20),
    Fecha DATE,
    Forma_Pago VARCHAR(20),
    FOREIGN KEY (Id_Comensal) REFERENCES Comensal(Id_Comensal)
);

CREATE TABLE Mesa (
    Id_Mesa VARCHAR(20),
    Id_Comensal VARCHAR(20),
    Id_PayMaster VARCHAR(20),
    CONSTRAINT PK_Mesa PRIMARY KEY (Id_Mesa, Id_Comensal),
    FOREIGN KEY (Id_Comensal) REFERENCES Comensal(Id_Comensal)
);

CREATE TABLE Contener (
    No_Pedido INTEGER,
    Id_Producto VARCHAR(20),
    Cantidad INTEGER,
    CONSTRAINT PK_Contener PRIMARY KEY (No_Pedido,Id_Producto),
    FOREIGN KEY (No_Pedido) REFERENCES Pedido(No_Pedido),
    FOREIGN KEY (Id_Producto) REFERENCES Producto(Id_Producto)
);

CREATE TABLE Producto(
    Id_Producto VARCHAR(20) PRIMARY KEY,
    Nombre VARCHAR(20),
    Precio INTEGER
);

CREATE TABLE CategoriaProducto (
    Id_Producto VARCHAR(20) PRIMARY KEY,
    Categoria VARCHAR(20),
    FOREIGN KEY (Id_Producto) REFERENCES Producto(Id_Producto)
);

CREATE TABLE Participar(
    Id_Producto VARCHAR(20),
    Nombre_Ingrediente VARCHAR(20),
    CONSTRAINT PK_Participar PRIMARY KEY (Id_Producto, Nombre_Ingrediente),
    FOREIGN KEY (Id_Producto) REFERENCES Producto(Id_Producto),
    FOREIGN KEY (Nombre_Ingrediente) REFERENCES Ingrediente(Nombre)
);

CREATE TABLE Ingrediente (
    Nombre VARCHAR(20) PRIMARY KEY
);

CREATE TABLE Consumir (
    Id_Comensal VARCHAR(20),
    Id_Pedido VARCHAR(20),
    Ticket INTEGER,
    CONSTRAINT PK_Consumir PRIMARY KEY (Id_Comensal, Id_Pedido),
    FOREIGN KEY (Id_Comensal) REFERENCES Comensal(Id_Comensal),
    FOREIGN KEY (Id_Pedido) REFERENCES Pedido(Id_Pedido)
);

CREATE TABLE EtiquetaProducto (
    Id_Producto VARCHAR(20),
    Etiqueta VARCHAR(20),
    CONSTRAINT PK_EtiquetaProducto PRIMARY KEY (Id_Producto, Etiqueta),
    FOREIGN KEY (Id_Producto) REFERENCES Producto(Id_Producto)
);

CREATE TABLE Salsa (
    Id_Producto VARCHAR(20) PRIMARY KEY,
    Nombre VARCHAR(20),
    Nivel_Picor INTEGER
);

CREATE TABLE PresentacionSalsa (
    Id_producto VARCHAR(20),
    Presentacion VARCHAR(20),
    CONSTRAINT PK_PresentacionSalsa PRIMARY KEY (Id_Producto, Presentacion),
    FOREIGN KEY (Id_Producto) REFERENCES Salsa(Id_Producto)
);

CREATE TABLE Emparejar (
    Id_Salsa VARCHAR(20),
    Id_Producto VARCHAR (20),
    CONSTRAINT PK_Emparejar PRIMARY KEY (Id_Salsa, Id_Producto),
    FOREIGN KEY (Id_Salsa)  REFERENCES Salsa(Id_Producto),
    FOREIGN KEY (Id_Producto) REFERENCES Producto(Id_Producto)
);

CREATE TABLE Repartidor (
    CURP_Repartidor VARCHAR(12),
    Codigo_Licencia INTEGER,
    CONSTRAINT PK_Repartidor PRIMARY KEY(CURP_Repartidor, Codigo_Licencia),
    FOREIGN KEY (CURP_Repartidor) REFERENCES Empleado(CURP_Empleado),
    FOREIGN KEY (Codigo_Licencia) REFERENCES Licencia (Codigo)
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
