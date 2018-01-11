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
    public static void addTableColumnsAndPopulateItDynamically(TableView<ObservableList> tableView,
                                                               String titleAlias,
                                                               List<String> columnNames,
                                                               ObservableList<ObservableList> data,
                                                               boolean populateTable) {
        data = FXCollections.observableArrayList();
        try {
            Connection c = DBUtil.getConnection();

            String sql = getQuery(titleAlias);

            ResultSet rs = c.createStatement().executeQuery(sql);

            for (int i = 0; i < rs.getMetaData().getColumnCount(); i++) {
                final int j = i;
                String aux = rs.getMetaData().getColumnName(i + 1);
                if (columnNames != null) {
                    columnNames.add(aux);
                }
                TableColumn col = new TableColumn(aux);
                col.setCellValueFactory((Callback<TableColumn.CellDataFeatures<ObservableList, String>, ObservableValue<String>>) param ->
                        new SimpleStringProperty(param.getValue().get(j).toString()));

                tableView.getColumns().addAll(col);
            }

            if (populateTable) {
                while (rs.next()) {
                    ObservableList<String> row = FXCollections.observableArrayList();
                    for (int i = 1; i <= rs.getMetaData().getColumnCount(); i++) {
                        String s = rs.getString(i);
                        row.add(s != null ? s : "");
                    }
                    data.add(row);
                }
            tableView.setItems(data);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

    }


    private static String getQuery(String titleAlias) {
        //TODO Hola Fer, aquí copias y pega el los selects que tienes dependiendo el nombre
        switch (titleAlias) {
            case "Taquerias":
                return "";
            case "Empleados":
                return "";
            case "Clientes":
                return "";
            case "Productos":
                return "";
            case "Provedores":
                return "";
            case "Menu":
                return "";
            default:
                return "";
        }
    }

}
