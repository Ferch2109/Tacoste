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
        switch (titleAlias) {
            case "Taquerias":
                return "select id_sucursal,gerente,direccion,tel1,tel2,tel3 from " +
                        "(select * from (select id_sucursal,\"1\" as tel1,\"2\" as tel2,\"3\" as tel3 from (select * from (select * from telefono_sucursal) natural join (SELECT id_sucursal, telefono, ROW_NUMBER() OVER (PARTITION BY id_sucursal ORDER BY id_sucursal) AS tel FROM telefono_sucursal) ) " +
                        "pivot ( sum(telefono) for tel in (1,2,3) ) order by id_sucursal) natural join " +
                        "(select * from gerencia_sucursal natural join (select curp, nombre||' '||paterno||' '||materno as gerente from empleado))) " +
                        "natural join " +
                        "(select id_sucursal,calle||' '||numero||', '||colonia||', '||cp||' '||municipio||', '||estado as direccion, hora_inicio,hora_cierre from informacion_sucursal) order by id_sucursal";
            case "Empleados":
                return "select * from (select * " +
                        "                from (select * from (select curp,rfc,nombre||' '||paterno||' '||materno as nombre, sueldo from empleado) " +
                        "                                    natural join " +
                        "                                    (select curp,colonia||', '||cp||' '||municipio||', '||estado as direccion,correo from datos_empleado natural join correo_empleado)) " +
                        "                      natural join (select curp,\"1\" as tel1,\"2\" as tel2,\"3\" as tel3 from (select * from (select * from telefono_empleado) natural join (SELECT curp, telefono_empleado, ROW_NUMBER() OVER (PARTITION BY curp ORDER BY curp) AS tel FROM telefono_empleado) ) " +
                        "                pivot ( sum(telefono_empleado) for tel in (1,2,3) ))) " +
                        "                natural join " +
                        "                (select curp,tipo,vigencia,transporte from repartidor natural join datos_licencia) " +
                        "order by nombre";
            case "Clientes":
                return "select * from (select id_comensal,nombre||' '||paterno||' '||materno as nombre from comensal) " +
                        "              natural join " +
                        "              (select id_comensal,calle||' '||numero||', '||colonia||', '||cp||' '||municipio||', '||estado as direccion,correo,telefono,puntos from datos_comensal) " +
                        "order by id_comensal";
            case "Productos":
                return "select distinct * from (select * from (select * from producto natural join categoria_producto) natural join etiqueta_producto) " +
                        "natural join (select emparejar.id_producto,nombre as salsa,nivel_picor from emparejar cross join salsa) order by id_producto;";
            case "Provedores":
                return "select * from IDENTIFICACION_PROVEEDOR natural join (select rfc,calle||' '||numero||', '||colonia||', '||cp||' '||municipio||', '||estado as direccion from datos_proveedor order by rfc)";
            case "Menu":
                return "select id_producto,nombre,categoria,precio from producto natural join categoria_producto order by id_producto";
            default:
                return "";
        }
    }

}
