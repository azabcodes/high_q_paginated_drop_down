import 'package:flutter/material.dart';
import '../../../high_q_paginated_drop_down.dart';

class DropDownCard<T> extends StatelessWidget {
  final bool isReversed;
  final bool showTextField;
  final Duration? searchDelayDuration;
  final InputDecoration? textFieldDecoration;
  final Future<List<MenuItemModel<T>>?> Function(int page, String? searchText)? paginatedRequest;
  final HighQPaginatedDropdownController<T> controller;

  final void Function(T? value)? onChanged;
  final Widget? loadingWidget;
  final Widget? noRecordText;
  final Widget Function(String searchEntry)? emptyBuilder;

  final Decoration? menuDecoration;
  final Widget Function(BuildContext context, int index)? separatorBuilder;

  final TextStyle? searchStyle;
  final Color? searchCursorColor;
  final TextAlign searchTextAlign;
  final double? elevation;
  final Color? shadowColor;
  final ShapeBorder? shape;
  final ScrollPhysics? scrollPhysics;
  final EdgeInsetsGeometry? listViewPadding;

  const DropDownCard({
    super.key,
    required this.controller,
    required this.showTextField,
    required this.isReversed,

    this.textFieldDecoration = const InputDecoration(isDense: true),
    this.paginatedRequest,
    this.onChanged,
    this.loadingWidget,
    this.noRecordText,
    this.emptyBuilder,
    this.searchDelayDuration,
    this.menuDecoration,
    this.separatorBuilder,
    this.searchStyle,
    this.searchCursorColor,
    this.searchTextAlign = TextAlign.start,
    this.elevation,
    this.shadowColor,
    this.shape,
    this.scrollPhysics,
    this.listViewPadding,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: isReversed ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Flexible(
          child: Material(
            elevation: elevation ?? 0.0,
            shadowColor: shadowColor,
            shape: shape,
            borderRadius: shape == null
                ? (menuDecoration is BoxDecoration
                          ? (menuDecoration as BoxDecoration).borderRadius
                          : BorderRadius.circular(10))
                      as BorderRadius?
                : null,
            clipBehavior: Clip.antiAlias,

            color: Colors.transparent,
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
                verticalDirection: isReversed ? VerticalDirection.up : VerticalDirection.down,
                children: [
                  if (showTextField == true)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: PackageSearchBar(
                        searchDelayDuration: searchDelayDuration ?? const Duration(milliseconds: 200),
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
                        style: searchStyle,
                        cursorColor: searchCursorColor,
                        textAlign: searchTextAlign,
                      ),
                    ),
                  Flexible(
                    child: DropDownListView(
                      dropdownController: controller,
                      paginatedRequest: paginatedRequest,
                      isReversed: isReversed,
                      noRecordText: noRecordText,
                      emptyBuilder: emptyBuilder,
                      onChanged: onChanged,
                      loadingWidget: loadingWidget,
                      separatorBuilder: separatorBuilder,
                      scrollPhysics: scrollPhysics,
                      listViewPadding: listViewPadding,
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
