package fbd.controller;

import fbd.model.OrderInfo;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.stage.Stage;

import java.io.IOException;

public class TableViewController {

    @FXML private void addProductByLaunchingAnotherScreen() throws IOException{
        FXMLLoader loader = new FXMLLoader(getClass().getResource("/fbd/view/fields_view.fxml"));
        Parent root = loader.load();

        loader.<FieldsController>getController().initView(FieldsController.Type.PRODUCT);

        Stage stage = new Stage();
        stage.setScene(new Scene(root));
        stage.showAndWait();

    }
}
