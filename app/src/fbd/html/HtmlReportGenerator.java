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
                "    <script src=\"pdf.js\"></script>\n" +
                "</head>\n" +
                "<body>\n" +
                "    <div class=\"titulo\">\n" +
                "        <h1>Tacoste</h1>\n" +
                "        <h2>Reporte</h2>\n" +
                "    </div>\n" +
                "    <hr>");

        for (QueryPair queryPair : queryPairs) {
            builder.append(createSectionForReport(queryPair));
        }

        builder.append("</body>" +
                "\n" +
                "</html>");
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

        } catch (SQLException ignored) {
        }

        builder.append("</table>" +
                "</div>");
        return builder.toString();
    }

}
