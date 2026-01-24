import 'dart:async';
import 'package:flutter/material.dart';
import '../../../high_q_paginated_drop_down.dart';

class DropDownListView<T> extends StatefulWidget {
  final bool isReversed;
  final Widget? loadingWidget;
  final Future<List<MenuItemModel<T>>?> Function(int page, String? searchText)? paginatedRequest;
  final HighQPaginatedDropdownController<T> dropdownController;
  final void Function(T? value)? onChanged;
  final Widget? noRecordText;
  final Widget Function(BuildContext context, String searchEntry)? emptyBuilder;
  final ScrollPhysics? scrollPhysics;
  final EdgeInsetsGeometry? listViewPadding;

  const DropDownListView({
    super.key,
    required this.dropdownController,
    required this.isReversed,
    this.paginatedRequest,
    this.noRecordText,
    this.emptyBuilder,
    this.onChanged,
    this.loadingWidget,
    this.separatorBuilder,
    this.scrollPhysics,
    this.listViewPadding,
  });

  final Widget Function(BuildContext context, int index)? separatorBuilder;

  @override
  State<DropDownListView<T>> createState() => _DropDownListViewState<T>();
}

class _DropDownListViewState<T> extends State<DropDownListView<T>> {
  ScrollController scrollController = ScrollController();
  Timer? timer;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(scrollControllerListener);
  }

  @override
  void dispose() {
    super.dispose();
    scrollController
      ..removeListener(scrollControllerListener)
      ..dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: widget.paginatedRequest != null
          ? widget.dropdownController.paginatedItemList
          : widget.dropdownController.searchedItems,
      builder: (context, List<MenuItemModel<T>>? itemList, child) {
        return itemList == null
            ? widget.loadingWidget != null
                  ? widget.loadingWidget!
                  : const Center(child: CircularProgressIndicator.adaptive())
            : itemList.isEmpty
            ? widget.emptyBuilder?.call(context, widget.dropdownController.searchText) ??
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: widget.noRecordText ?? const Text('No record'),
                  )
            : Scrollbar(
                thumbVisibility: true,
                controller: scrollController,
                child: NotificationListener(
                  child: ListView.separated(
                    physics: widget.scrollPhysics ?? const AlwaysScrollableScrollPhysics(),
                    separatorBuilder: widget.separatorBuilder ?? (context, index) => const SizedBox.shrink(),
                    controller: scrollController,
                    padding: widget.listViewPadding ?? listViewPadding(isReversed: widget.isReversed),
                    itemCount: itemList.length + 1,
                    shrinkWrap: true,
                    reverse: widget.isReversed,
                    itemBuilder: (context, index) {
                      if (index < itemList.length) {
                        final item = itemList.elementAt(index);
                        return PackageInkwellWidget(
                          child: item.child!,
                          onTap: () {
                            widget.dropdownController.selectedItem.value = item;
                            widget.onChanged?.call(item.value);
                            Navigator.pop(context);
                            item.onTap?.call();
                          },
                        );
                      } else {
                        return ValueListenableBuilder(
                          valueListenable: widget.dropdownController.status,
                          builder:
                              (
                                context,
                                HighQPaginatedDropdownStatus state,
                                child,
                              ) {
                                if (state == HighQPaginatedDropdownStatus.busy) {
                                  return Center(
                                    child: widget.loadingWidget != null
                                        ? widget.loadingWidget!
                                        : const Center(
                                            child: CircularProgressIndicator.adaptive(),
                                          ),
                                  );
                                }
                                return const SizedBox.shrink();
                              },
                        );
                      }
                    },
                  ),
                ),
              );
      },
    );
  }

  EdgeInsets listViewPadding({required bool isReversed}) {
    final itemHeight = widget.paginatedRequest != null ? 48.0 : 0.0;
    return EdgeInsets.only(
      left: 8,
      right: 8,
      bottom: isReversed ? 0 : itemHeight,
      top: isReversed ? itemHeight : 0,
    );
  }

  void scrollControllerListener({
    double sensitivity = 150.0,
    Duration throttleDuration = const Duration(milliseconds: 400),
  }) {
    if (timer != null) return;

    timer = Timer(throttleDuration, () => timer = null);

    final position = scrollController.position;
    final maxScroll = scrollController.position.maxScrollExtent;
    final currentScroll = position.pixels;
    final dropdownController = widget.dropdownController;
    final searchText = dropdownController.searchText;
    if (maxScroll - currentScroll <= sensitivity) {
      if (searchText.isNotEmpty) {
        dropdownController.getItemsWithPaginatedRequest(
          page: dropdownController.page,
          searchText: searchText,
        );
      } else {
        dropdownController.getItemsWithPaginatedRequest(
          page: dropdownController.page,
        );
      }
    }
  }
}
