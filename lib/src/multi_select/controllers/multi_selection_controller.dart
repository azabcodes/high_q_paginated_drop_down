import 'package:flutter/material.dart';

class MultiSelectController<T> {
  VoidCallback? clearSelectionCallback;
  List<T> Function()? getSelectedItemsCallback;

  MultiSelectController({this.clearSelectionCallback});

  void clearSelection() {
    if (clearSelectionCallback != null) {
      clearSelectionCallback!();
    }
  }

  List<T> get selectedItems {
    return getSelectedItemsCallback?.call() ?? [];
  }

  void dispose() {
    clearSelectionCallback = null;
    getSelectedItemsCallback = null;
  }
}
