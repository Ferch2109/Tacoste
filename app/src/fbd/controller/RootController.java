package fbd.controller;

import fbd.model.OrderInfo;
import fbd.util.DBUtil;
import fbd.util.TableViewUtil;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.control.Label;
import javafx.scene.control.TableView;
import javafx.stage.Stage;

import java.awt.*;
import java.io.File;
import java.io.IOException;

public class RootController {

    @FXML Label labelConnectionStatus;
    @FXML TableView tableViewProducts;
    @FXML TableView tableOrderedProducts;

    private boolean menuPopulated = false;


    /*** MenuBar ***/

    @FXML private void launchTaqueriasSection() throws IOException {
        loadView("Taquerias");
    }

    @FXML private void launchEmployeesSection() throws IOException {
        loadView("Empleados");
    }

    @FXML private void launchClientsSection() throws IOException {
        loadView("Clientes");
    }

    @FXML private void launchProductsSection() throws IOException {
        loadView("Productos");
    }

    @FXML private void launchProvidersSection() throws IOException {
        loadView("Provedores");
    }

    @FXML private void launchGenerateReport() throws IOException {
        //TODO Fer ayuda, ya abre el hhtml pero no sé como meterle los datos.
        Desktop.getDesktop().browse(new File("../web/Reporte.html").toURI());
    }

    private void loadView(String sceneTitle) throws IOException {
        FXMLLoader loader = new FXMLLoader(getClass().getResource("/fbd/view/table_view.fxml"));
        Parent root = loader.load();

        TableViewController controller = loader.getController();
        controller.initialize(sceneTitle);
        Stage stage = new Stage();
        stage.setScene(new Scene(root));
        stage.setTitle(sceneTitle);
        stage.showAndWait();
    }

    /*** MenuBar ***/


    @FXML private void testConnection() {
        if (DBUtil.getConnection() == null) {
            labelConnectionStatus.setText("No se pudo estblecer conexión :'v");
        } else {
            labelConnectionStatus.setText("Conexión establecida");
            if (!menuPopulated) {
                populateMenuTable();
            }
        }
    }

    private void populateMenuTable() {
        menuPopulated = true;

        TableViewUtil.addTableColumnsAndPopulateItDynamically(tableViewProducts, "Menu", null, null, true);
        TableViewUtil.addTableColumnsAndPopulateItDynamically(tableOrderedProducts, "Menu", null, null, false);
    }

    @FXML private void addProductFromMenu() {

    }

    @FXML private void removeProductFromOrderList() {
    }

    @FXML private void orderProductsFromOrderList() throws IOException {
        FXMLLoader loader = new FXMLLoader(getClass().getResource("/fbd/view/order_info_view.fxml"));
        Parent root = loader.load();

        loader.<OrderInfoController>getController().setData(new OrderInfo());

        Stage stage = new Stage();
        stage.setScene(new Scene(root));
        stage.showAndWait();
    }

}
