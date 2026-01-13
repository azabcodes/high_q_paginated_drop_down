import '../../high_q_paginated_drop_down.dart';

class ItemsLogicProps<T> {
  final List<T> items;
  final List<T> initialSelectedItems;
  final MultiSelectDropDownOnFind<T>? asyncItems;
  final MultiSelectDropDownItemAsString<T>? itemAsString;

  const ItemsLogicProps({
    this.items = const [],
    this.initialSelectedItems = const [],
    this.asyncItems,
    this.itemAsString,
  });
}
