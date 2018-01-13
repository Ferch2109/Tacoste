package fbd.html;

import java.util.List;

public class QueryPair {

    //TODO: Fer llena esta lista con el titulo de la consulta y el query de la consulta. Deben de ser 15.
    //Ahorita repetí lo mismo para ver si funcionaba.
    public static List<QueryPair> hardcodedQueryPairs =
            List.of(new QueryPair("Información Sucursal 1",
                            "select * from informacion_sucursal"),
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
