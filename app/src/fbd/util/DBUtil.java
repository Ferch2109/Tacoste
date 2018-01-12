package fbd.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBUtil {

    //TODO pon descomenta las líneas y comenta las otras de url, user y password
    static private String url = "jdbc:oracle:thin:system/@localhost:1521:orcl";
    static String user = "system";
    static String password = "Freyja2109";
    //static private String url = "jdbc:mysql://localhost:3306/blog";
    //static private String user = "root";
    //static private String password = "";

    public static Connection getConnection() {
        Connection db = null;
        try {
            Class.forName("oracle.jdbc.OracleDriver");
            db = DriverManager.getConnection(url, user, password);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            System.out.println("HELLO");
        }
        return db;
    }

}
