package fbd.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;

public class DBUtil {
    //static private String url = "jdbc:oracle:thin:system/@localhost:1521:orcl";
    //String user = "system";
    //String password = "Freyja2109";
    static private String url = "jdbc:mysql://localhost:3306/blog";
    static private String user = "root";
    static private String password = "";

    public static Connection getConnection() {
        Connection db = null;
        try {
            //Class.forName("oracle.jdbc.OracleDriver");
            db = DriverManager.getConnection(url, user, password);
        } catch (SQLException  e) {
            e.printStackTrace();
        }
        return db;
    }

    //public static <T>ResultSet
}
