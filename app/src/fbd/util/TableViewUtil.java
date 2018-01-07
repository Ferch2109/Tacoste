package fbd.util;

import javafx.beans.property.SimpleStringProperty;
import javafx.beans.value.ObservableValue;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.scene.control.TableColumn;
import javafx.scene.control.TableView;
import javafx.util.Callback;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;


public class TableViewUtil {

    @SuppressWarnings("unchecked")
    public static void addTableColumnsDynamically(TableView<ObservableList> tableView,
                                                  String titleAlias,
                                                  List<String> columnNames,
                                                  ObservableList<ObservableList> data) {
        data = FXCollections.observableArrayList();
        try {
            Connection c;
            c = DBUtil.getConnection();
            //SQL FOR SELECTING ALL OF CUSTOMER
            String SQL = "SELECT * FROM " + getTable(titleAlias);
            //ResultSet
            ResultSet rs = c.createStatement().executeQuery(SQL);

            /**********************************
             * TABLE COLUMN ADDED DYNAMICALLY *
             **********************************/
            for (int i = 0; i < rs.getMetaData().getColumnCount(); i++) {
                //We are using non property style for making dynamic table
                final int j = i;
                String aux = rs.getMetaData().getColumnName(i + 1);
                columnNames.add(aux);
                TableColumn col = new TableColumn(aux);
                col.setCellValueFactory((Callback<TableColumn.CellDataFeatures<ObservableList, String>, ObservableValue<String>>) param ->
                        new SimpleStringProperty(param.getValue().get(j).toString()));

                tableView.getColumns().addAll(col);
                System.out.println("Column [" + i + "] ");
            }

            while (rs.next()) {
                //Iterate Row
                ObservableList<String> row = FXCollections.observableArrayList();
                for (int i = 1; i <= rs.getMetaData().getColumnCount(); i++) {
                    //Iterate Column
                    String s = rs.getString(i);
                    row.add(s != null ? s : "");
                }
                System.out.println("Row [1] added " + row);
                data.add(row);

            }

            //FINALLY ADDED TO TableView
            tableView.setItems(data);

        } catch (SQLException e) {
            e.printStackTrace();
        }

    }


    private static String getTable(String titleAlias) {
        //TODO completear el pendejo nombre de las putas tablas
        switch (titleAlias) {
            case "Taquerias":
                return "informacion_sucursal";
            case "Empleados":
                return "";
            case "Clientes":
                return "";
            case "Productos":
                return "";
            case "Provedores":
                return "";
            default:
                return "";
        }
    }

}
