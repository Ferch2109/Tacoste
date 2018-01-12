package fbd.controller;

import fbd.util.TableViewUtil;
import javafx.collections.ObservableList;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.control.TableView;
import javafx.stage.Stage;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class TableViewController {

    @FXML TableView<ObservableList> tableView;

    private ObservableList<ObservableList> data;
    List<String> columnNames;
    private String titleAlias;

    @FXML private void addProductByLaunchingAnotherScreen() throws IOException {
        FXMLLoader loader = new FXMLLoader(getClass().getResource("/fbd/view/fields_view.fxml"));
        Parent root = loader.load();

        loader.<FieldsController>getController().initView(columnNames, FieldsController.ACTION.ADD);

        Stage stage = new Stage();
        stage.setScene(new Scene(root));

        stage.showAndWait();
    }


    public void initialize(String titleAlias) {
        this.titleAlias = titleAlias;
        columnNames = new ArrayList<>();
        TableViewUtil.addTableColumnsAndPopulateItDynamically(tableView, this.titleAlias, columnNames, data, true);
        //System.out.println(tableView.);

    }


    @FXML private void modifyProductByLaunchingAnotherScreen() {

    }

    @FXML private void deleteProduct() {

        //fixme PUTAS VALIDACIONES SI ES PUTA VACIA
        int i = tableView.getSelectionModel().getFocusedIndex();
        tableView.getItems().remove(i);
    }
}
