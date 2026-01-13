import 'package:flutter/material.dart';
import '../../high_q_paginated_drop_down.dart';

class DropDownCard<T> extends StatelessWidget {
  final bool isReversed;
  final bool showTextField;
  final Duration? searchDelayDuration;
  final InputDecoration? textFieldDecoration;
  final Future<List<MenuItemModel<T>>?> Function(int page, String? searchText)?
  paginatedRequest;
  final PaginatedSearchDropdownController<T> controller;
  final String? searchHintText;
  final void Function(T? value)? onChanged;
  final Widget? loadingWidget;
  final Widget? noRecordText;

  final Decoration? menuDecoration;
  final Widget Function(BuildContext context, int index)? separatorBuilder;

  const DropDownCard({
    super.key,
    required this.controller,
    required this.showTextField,
    required this.isReversed,
    this.searchHintText,
    this.textFieldDecoration = const InputDecoration(isDense: true),
    this.paginatedRequest,
    this.onChanged,
    this.loadingWidget,
    this.noRecordText,
    this.searchDelayDuration,
    this.menuDecoration,
    this.separatorBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: isReversed
          ? MainAxisAlignment.end
          : MainAxisAlignment.start,
      children: [
        Flexible(
          child: Material(
            child: Container(
              margin: EdgeInsets.zero,

              decoration:
                  menuDecoration ??
                  BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                verticalDirection: isReversed
                    ? VerticalDirection.up
                    : VerticalDirection.down,
                children: [
                  if (showTextField == true)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: PackageSearchBar(
                        searchDelayDuration:
                            searchDelayDuration ??
                            const Duration(milliseconds: 200),
                        hintText: searchHintText ?? 'Search',

                        onChangeComplete: (value) {
                          controller.searchText = value;
                          if (controller.items != null) {
                            controller.fillSearchedList(value);
                            return;
                          }
                          controller.getItemsWithPaginatedRequest(
                            searchText: value == '' ? null : value,
                            page: 1,
                            isNewSearch: true,
                          );
                        },
                        textFieldDecoration: textFieldDecoration,
                      ),
                    ),
                  Flexible(
                    child: DropDownListView(
                      dropdownController: controller,
                      paginatedRequest: paginatedRequest,
                      isReversed: isReversed,
                      noRecordText: noRecordText,
                      onChanged: onChanged,
                      loadingWidget: loadingWidget,
                      separatorBuilder: separatorBuilder,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
