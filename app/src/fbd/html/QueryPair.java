package fbd.html;

import java.util.List;

public class QueryPair {

    //TODO: Fer llena esta lista con el titulo de la consulta y el query de la consulta. Deben de ser 15.
    //Ahorita repetí lo mismo para ver si funcionaba.
    public static List<QueryPair> hardcodedQueryPairs =
            List.of(new QueryPair("Comensales que más han consumido\n(nombre completo,veces que consumió, total pagado) ",
                            "select nombre||' '||paterno||' '||materno as nombre, veces_consumo, total " +
                                    "from  (select id_comensal,sum(precio) as total " +
                                    "      from (select * from consumir natural join contener) " +
                                    "      natural join producto group by id_comensal) " +
                                    "natural join (select * from comensal " +
                                    "              natural join (select id_comensal,count(id_comensal) as veces_consumo " +
                                    "              from consumir group by id_comensal " +
                                    "having count(id_comensal) = (select max(count(id_comensal)) from consumir group by id_comensal)))"),
                    new QueryPair("Venta de salsas (Nombre salsa,precio, numero de ventas,nivel picor)",
                            "select salsa as nombre,nivel_picor,numero_ventas,precio " +
                                    "from (select id_producto,nombre as salsa,numero_ventas,nivel_picor " +
                                    "      from (select id_producto,sum(cantidad) as numero_ventas from contener group by id_producto) " +
                                    "      natural join salsa) " +
                                    "natural join producto"),
                    new QueryPair("Venta de las salsas en el último año (Nombre salsa,precio, numero de ventas) ",
                            "select salsa as nombre,nivel_picor,numero_ventas,precio " +
                                    "from (select id_producto,nombre as salsa,numero_ventas,nivel_picor " +
                                    "      from (select id_producto,sum(cantidad) as numero_ventas " +
                                    "            from (select * " +
                                    "                  from contener natural join pedido " +
                                    "                  where EXTRACT(YEAR FROM fecha) in (SELECT EXTRACT(YEAR FROM sysdate) FROM dual)) group by id_producto) " +
                                    "natural join salsa) " +
                                    "natural join producto order by numero_ventas desc"),
                    new QueryPair("Todos los empleados que tienen como sueldo $5000 o mas(RFC,nombre completo,sucursal)",
                                          "SELECT rfc,nombre||' '||paterno||' '||materno as nombre, id_sucursal as sucursal " +
                                                  " FROM (select * FROM empleado WHERE sueldo >= 5000) natural join empleado_sucursal"),
                    new QueryPair("RFC,nombre completo de los empleados que son gerentes y su sucursal",
                                          "SELECT rfc,nombre||' '||paterno||' '||materno as nombre, id_sucursal as sucursal " +
                                                  "FROM empleado NATURAL JOIN gerencia_sucursal"),
                    new QueryPair("Curp,rfc y ombre completo de las personas que son empleados excepto repartidores",
                            "SELECT curp,nombre||' '||paterno||' '||materno as nombre,rfc\n" +
                                    "FROM empleado\n" +
                                    "WHERE curp in (SELECT curp\n" +
                                    "                           FROM empleado\n" +
                                    "                           MINUS\n" +
                                    "                           SELECT curp\n" +
                                    "                          FROM repartidor);"),
                    new QueryPair("Esta consulta nos muestra con que prefieren pagar los clientes, para\n" +
                            "--esto usamos\n" +
                            "--tablas temporales, para almacenar cuántas veces se paga con qué\n" +
                            "--metodo y después. Únicamente sacar el máximo.",
                            "CREATE TABLE cuenta_veces " +
                                    "AS SELECT count(forma_pago) pago FROM pedido " +
                                    "WHERE (lower(forma_pago) = 'efectivo') OR (lower(forma_pago) = 'tarjeta') " +
                                    "GROUP BY forma_pago; " +
                                    "SELECT max(pago) as preferida FROM cuenta_veces"),
                    new QueryPair("Salsa que más participa en los productos.",
                            "CREATE TABLE cuenta_apariciones " +
                                    "AS SELECT count(id_salsa) veces FROM emparejar " +
                                    "GROUP BY id_salsa; " +
                                    "SELECT * FROM salsa " +
                                    "WHERE id_producto = (SELECT max(veces) FROM cuenta_apariciones)"),
                    new QueryPair("Producto más pedido en cualquier sucursal.",
                            "CREATE TABLE veces_productos " +
                                    "AS SELECT count(id_producto) apariciones FROM contener " +
                                    "GROUP BY id_producto; " +
                                    "SELECT nombre FROM producto " +
                                    "WHERE id_producto = (SELECT max(apariciones) FROM veces_productos)"),
                    new QueryPair("Información Sucursal 3",
                            "select * from informacion_sucursal"));

    private String reportTitle;
    private String sqlQuery;

    /**
     * @param reportTitle The title of the report
     * @param sqlQuery    The sql query
     */
    public QueryPair(String reportTitle, String sqlQuery) {
        this.reportTitle = reportTitle;
        this.sqlQuery = sqlQuery;
    }

    String getReportTitle() {
        return reportTitle;
    }

    String getSqlQuery() {
        return sqlQuery;
    }
}
