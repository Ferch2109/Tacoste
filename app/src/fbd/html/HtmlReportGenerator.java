package fbd.html;

import fbd.util.DBUtil;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

public class HtmlReportGenerator {
    public static String getWholeHtml(List<QueryPair> queryPairs) {
        StringBuilder builder = new StringBuilder();
        builder.append("<!DOCTYPE html>\n" +
                "<html>\n" +
                "<head>\n" +
                "    <title>Reporte</title>\n" +
                "    <link rel=\"stylesheet\" type=\"text/css\" href=\"reporte.css\">\n" +
                "    <!--<<script type=\"conic-gradient.js\"></script>-->\n" +
                "    <script src=\"pdf.js\"></script>\n" +
                "       <script src=\"https://cdnjs.cloudflare.com/ajax/libs/jspdf/1.3.2/jspdf.debug.js\"></script> \n" +
                "       <script type=\"text/javascript\" src=\"html2canvas.js\"></script>\n" +
                "       <script type=\"text/javascript\" src=\"https://code.jquery.com/jquery-2.1.3.js\"></script>\n" +
                "</head>\n" +
                "<body>\n" +
                "    <div style='margin-bottom: -35px'><button onclick=\"descargar()\">Descargar</button></div>\n" +
                "    <div class = \"titulo\">\n" +
                "        <div>\n" +
                "            <h1>Reporte</h1>\n" +
                "            <h2>Tacoste, SA. tacoste@gmail.com</h2>\n" +
                "        </div>\n" +
                "        <div><img src='tacoste.png'></div>\n" +
                "    </div>");

        for (QueryPair queryPair : queryPairs) {
            builder.append(createSectionForReport(queryPair));
        }

        builder.append("</body><footer><h2>Tacoste, SA. || tacoste@gmail.com || www.tacoste.com.mx</h2></footer></html>");
        return builder.toString();
    }

    private static String createSectionForReport(QueryPair queryPair) {
        StringBuilder builder = new StringBuilder();
        builder.append("<div class=\"reporte\">" +
                "<h2>" +
                queryPair.getReportTitle() +
                "</h2>\n" +
                "<table style=\"width:100%\">\n");

        try {
            //Column names by getting metadata query.
            Connection c = DBUtil.getConnection();
            ResultSet rs = c.createStatement().executeQuery(queryPair.getSqlQuery());

            builder.append("<tr>\n");
            for (int i = 0; i < rs.getMetaData().getColumnCount(); i++) {
                String columnName = rs.getMetaData().getColumnName(i + 1);
                builder.append("<th>")
                        .append(columnName)
                        .append("</th>\n");
            }
            builder.append("</tr>\n");

            while (rs.next()) {
                //Iterate each row
                builder.append("<tr>\n");
                for (int i = 1; i <= rs.getMetaData().getColumnCount(); i++) {
                    String value = rs.getString(i) == null ? "" : rs.getString(i);
                    builder.append("<td>")
                            .append(value)
                            .append("</td>\n");
                }
                builder.append("</tr>\n");
            }

        } catch (Exception ignored) {
        }

        builder.append("</table>" +
                "</div>");
        return builder.toString();
    }

}
