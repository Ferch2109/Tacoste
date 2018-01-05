package fbd.controller;

import fbd.util.TableViewUtil;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.control.TableView;
import javafx.stage.Stage;

import java.io.IOException;

public class TableViewController {

    @FXML TableView<ObservableList> tableView;

    private ObservableList<ObservableList> data;


    @FXML private void addProductByLaunchingAnotherScreen() throws IOException {
        FXMLLoader loader = new FXMLLoader(getClass().getResource("/fbd/view/fields_view.fxml"));
        Parent root = loader.load();

        loader.<FieldsController>getController().initView(FieldsController.Type.PRODUCT);

        Stage stage = new Stage();
        stage.setScene(new Scene(root));
        stage.showAndWait();

    }


    public void initialize(String titleAlias) {
        data = FXCollections.observableArrayList();
        TableViewUtil.addTableColumnsDynamically(tableView, titleAlias, data);
    }


    @FXML private void modifyProductByLaunchingAnotherScreen() {

    }

    @FXML private void deleteProduct() {

        //fixme PUTAS VALIDACIONES SI ES PUTA VACIA
        int i = tableView.getSelectionModel().getFocusedIndex();
        tableView.getItems().remove(i);
    }
}
