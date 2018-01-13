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
                    new QueryPair("Información Sucursal 2",
                            "select * from informacion_sucursal"),
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
