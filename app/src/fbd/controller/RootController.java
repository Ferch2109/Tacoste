package fbd.controller;

import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.control.Label;
import javafx.stage.Stage;

import java.io.IOException;

public class RootController {

    @FXML Label labelConnectionStatus;


    /*** MenuBar ***/

    @FXML private void launchTaqueriasSection() throws IOException {
        loadView("Taquerias");
    }


    @FXML private void launchEmployeesSection() throws IOException {
        loadView("Empleados");
        System.out.println(7);
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

    @FXML private void launchGenerateReport(){
        //TODO: Generar reporte bonito
    }

    private void loadView(String sceneTitle) throws IOException {
        FXMLLoader loader = new FXMLLoader(getClass().getResource("/fbd/view/table_view.fxml"));
        Parent root = loader.load();

        TableViewController controller = loader.getController();
        Stage stage = new Stage();
        stage.setScene(new Scene(root));
        stage.setTitle(sceneTitle);
        stage.showAndWait();
    }

    /*** MenuBar ***/


    @FXML private void testConnection() {
        labelConnectionStatus.setText("TODO");
    }

    @FXML private void addProductFromMenu() {
    }

    @FXML private void removeProductFromOrderList() {
    }

    @FXML private void orderProductsFromOrderList() throws  IOException{
        //FIXME no sirve
        FXMLLoader loader = FXMLLoader.load(getClass().getResource("/fbd/view/order_info_view.fxml"));
        Parent root = loader.load();

        OrderInfoController controller = loader.getController();
        controller.setData(new OrderInfoController());
        Stage stage = new Stage();
        stage.setScene(new Scene(root));
        stage.showAndWait();
    }

}
