import 'package:flutter/material.dart';
import '../../high_q_paginated_drop_down.dart';

class DropDownText<T> extends StatelessWidget {
  final PaginatedSearchDropdownController<T> controller;
  final Widget Function(BuildContext context, T? item)? selectedItemBuilder;
  final Widget? hintText;

  const DropDownText({
    super.key,
    required this.controller,
    this.hintText,
    this.selectedItemBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: controller.selectedItem,
      builder: (context, MenuItemModel<T>? selectedItem, child) {
        if (selectedItemBuilder != null) {
          return selectedItemBuilder!(context, selectedItem?.value);
        }
        return selectedItem?.child ??
            (selectedItem?.label != null
                ? Text(
                    selectedItem!.label,
                    maxLines: 1,
                    overflow: TextOverflow.fade,
                  )
                : hintText) ??
            const SizedBox.shrink();
      },
    );
  }
}
