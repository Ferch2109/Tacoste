--Restricciones Parte Quiños

-- Restricciones Sucursal

ALTER TABLE sucursal ADD CONSTRAINT pk_id_sucursal PRIMARY KEY(id_sucursal);
ALTER TABLE gerencia_sucursal ADD CONSTRAINT fk_id_sucursal FOREIGN KEY (id_sucursal) REFERENCES sucursal(id_sucursal);
ALTER TABLE gerencia_sucursal ADD CONSTRAINT fk_curp FOREIGN KEY (curp) REFERENCES empleado(curp);
ALTER TABLE informacion_sucursal ADD CONSTRAINT fk_id_sucursal1 FOREIGN KEY (id_sucursal) REFERENCES sucursal(id_sucursal);
ALTER TABLE telefono_sucursal ADD CONSTRAINT fk_id_sucursal2 FOREIGN KEY (id_sucursal) REFERENCES sucursal(id_sucursal);

--Empleado

ALTER TABLE empleado ADD CONSTRAINT pk_curp PRIMARY KEY(curp);
ALTER TABLE datos_empleado ADD CONSTRAINT fk_curp1 FOREIGN KEY (curp) REFERENCES empleado(curp);
ALTER TABLE correo_empleado ADD CONSTRAINT fk_curp2 FOREIGN KEY (curp) REFERENCES empleado(curp);
ALTER TABLE telefono_empleado ADD CONSTRAINT fk_curp3 FOREIGN KEY (curp) REFERENCES empleado(curp);
ALTER TABLE supervisar2 ADD CONSTRAINT fk_curp4 FOREIGN KEY (curp) REFERENCES empleado(curp);

--Supervisar
ALTER TABLE supervisar ADD CONSTRAINT fk_curp_4 FOREIGN KEY (curp) REFERENCES empleado(curp);


--Licencia
ALTER TABLE licencia ADD CONSTRAINT pk_codigo PRIMARY KEY(codigo);
ALTER TABLE licencia_repartidor ADD CONSTRAINT fk_codigo FOREIGN KEY (codigo) REFERENCES licencia(codigo);
ALTER TABLE licencia_repartidor ADD CONSTRAINT fk_curps FOREIGN KEY (curp) REFERENCES empleados(curp);
ALTER TABLE datos_licencia ADD CONSTRAINT fk_codigo1 FOREIGN KEY (codigo) REFERENCES licencia(codigo);

--Proveedor
ALTER TABLE proveedor ADD CONSTRAINT pk_rfc1 PRIMARY KEY(rfc);
ALTER TABLE identificacion_proveedor ADD CONSTRAINT fk_rfc1 FOREIGN KEY (rfc) REFERENCES proveedor(rfc);
ALTER TABLE datos_proveedor ADD CONSTRAINT fk_rfc_dos FOREIGN KEY (rfc) REFERENCES proveedor(rfc);

--Suministro
ALTER TABLE suministro ADD CONSTRAINT pk_id_suministro PRIMARY KEY(id_suministro);
ALTER TABLE nombre_suministro ADD CONSTRAINT fk_id_suministro FOREIGN KEY (id_suministro) REFERENCES suministro(id_suministro);
ALTER TABLE datos_suministro ADD CONSTRAINT fk_id_suministro1 FOREIGN KEY (id_suministro) REFERENCES suministro(id_suministro);
ALTER TABLE datos_suministro ADD CONSTRAINT fk_rfc_3 FOREIGN KEY (rfc) REFERENCES proveedor(rfc);

--Inventario
ALTER TABLE inventario ADD CONSTRAINT pk_no_lote PRIMARY KEY(no_lote);

--Suministrar
ALTER TABLE suministrar ADD CONSTRAINT fk_id_suministro2 FOREIGN KEY (id_suministro) REFERENCES suministro(id_suministro);
ALTER TABLE suministrar ADD CONSTRAINT fk_no_lote FOREIGN KEY (no_lote) REFERENCES inventario(no_lote);

ALTER TABLE generar ADD CONSTRAINT fk_id_sucursal_3 FOREIGN KEY (id_sucursal) REFERENCES sucursal(id_sucursal);
ALTER TABLE generar ADD CONSTRAINT fk_no_lote_1 FOREIGN KEY (no_lote) REFERENCES inventario(no_lote);
