import 'dart:async';
import 'package:flutter/material.dart';
import '../../../high_q_paginated_drop_down.dart';

// ignore: prefer-match-file-name
enum HighQPaginatedDropdownStatus {
  initial,
  busy,
  error,
  loaded,
}

class HighQPaginatedDropdownController<T> {
  HighQPaginatedDropdownController({MenuItemModel<T>? initialItem}) {
    if (initialItem != null) selectedItem.value = initialItem;
  }

  final GlobalKey key = GlobalKey();
  final ValueNotifier<List<MenuItemModel<T>>?> paginatedItemList = ValueNotifier<List<MenuItemModel<T>>?>(null);
  final ValueNotifier<MenuItemModel<T>?> selectedItem = ValueNotifier<MenuItemModel<T>?>(null);
  final ValueNotifier<HighQPaginatedDropdownStatus> status = ValueNotifier<HighQPaginatedDropdownStatus>(
    HighQPaginatedDropdownStatus.initial,
  );

  Future<List<MenuItemModel<T>>?> Function(int page, String? key)? paginatedRequest;

  int requestItemCount = 0;

  List<MenuItemModel<T>>? items;

  String searchText = '';
  final ValueNotifier<List<MenuItemModel<T>>?> searchedItems = ValueNotifier<List<MenuItemModel<T>>?>(null);

  bool _hasMoreData = true;
  int _page = 1;

  int get page => _page;

  Future<void> getItemsWithPaginatedRequest({
    required int page,
    String? searchText,
    bool isNewSearch = false,
  }) async {
    if (paginatedRequest == null) return;
    if (isNewSearch) {
      _page = 1;
      paginatedItemList.value = null;
      _hasMoreData = true;
    }
    if (!_hasMoreData) return;
    status.value = HighQPaginatedDropdownStatus.busy;
    final response = await paginatedRequest!(page, searchText);
    if (response is! List<MenuItemModel<T>>) return;

    paginatedItemList.value ??= [];
    paginatedItemList.value = paginatedItemList.value! + response;
    if (response.length < requestItemCount) {
      _hasMoreData = false;
    } else {
      _page = _page + 1;
    }
    status.value = HighQPaginatedDropdownStatus.loaded;
  }

  void fillSearchedList(String? value) {
    if (value == null || value.isEmpty) searchedItems.value = items;

    final tempList = <MenuItemModel<T>>[];
    for (final element in items ?? <MenuItemModel<T>>[]) {
      if (element.label.containsWithTurkishChars(value!)) tempList.add(element);
    }
    searchedItems.value = tempList;
  }

  void clear() {
    selectedItem.value = null;
  }

  void dispose() {
    paginatedItemList.dispose();
    selectedItem.dispose();
    status.dispose();
    searchedItems.dispose();
  }
}
