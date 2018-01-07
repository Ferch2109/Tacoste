package fbd.controller;

import javafx.collections.ObservableList;
import javafx.fxml.FXML;
import javafx.geometry.Insets;
import javafx.scene.control.Label;
import javafx.scene.control.TableColumn;
import javafx.scene.control.TextField;
import javafx.scene.layout.HBox;
import javafx.scene.layout.VBox;

import java.util.List;

public class FieldsController {

    @FXML Label title;
    @FXML VBox vBox;

    void initView(List<String> columnNames, ACTION action) {
        title.setText(action == ACTION.ADD ? "Agregar" : "Modificar");

        for (int i = 0, n = columnNames.size(); i < n; i++) {
            addHBoxAsChildToVBoxDynamically(columnNames.get(n - i - 1), i);
        }
    }

    void initView(ObservableList<TableColumn<ObservableList, ?>> columnNames, ACTION action, List<String> item) {
        //TODO: modificar
    }

    private void addHBoxAsChildToVBoxDynamically(String columnName, int index) {
        HBox hBox = new HBox();
        hBox.setPrefHeight(0);
        hBox.setPrefWidth(234);

        Label label = new Label();
        label.prefHeight(17);
        label.setPrefWidth(159);
        label.setText(columnName);
        label.setId("label" + index);

        TextField textField = new TextField();
        textField.prefHeight(27);
        textField.setPrefWidth(223);
        textField.setId("textField" + index);

        hBox.setPadding(new Insets(0, 0, 10, 0));

        hBox.getChildren().add(label);
        hBox.getChildren().add(textField);

        vBox.getChildren().add(0, hBox);
    }


    @FXML private void addItem() {
        //TODO
    }

    @FXML private void cancel() {
        //TODO
    }

    enum ACTION {ADD, MODIFY}
}

