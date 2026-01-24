import 'package:flutter/material.dart';
import '../../../high_q_paginated_drop_down.dart';

class DropDown<T> extends StatelessWidget {
  final bool isEnabled;
  final bool showTextField;
  final Widget loadingWidget;
  final bool isDialogExpanded;
  final InputDecoration? textFieldDecoration;
  final double? paddingValueWhileIsDialogExpanded;
  final bool hasTrailingClearIcon;
  final double? dropDownMaxHeight;
  final double? spaceBetweenDropDownAndItemsDialog;
  final Decoration? menuDecoration;
  final Widget Function(BuildContext context, int index)? separatorBuilder;
  final Widget Function(BuildContext context, T? item)? selectedItemBuilder;
  final Color? barrierColor;
  final bool? barrierDismissible;

  //Delay of DropDown's search callback after typing complete.
  final Duration? searchDelayDuration;
  final EdgeInsetsGeometry? padding;
  final Future<List<MenuItemModel<T>>?> Function(int page, String? searchText)? paginatedRequest;
  final HighQPaginatedDropdownController<T> controller;

  final VoidCallback? onTapWhileDisableDropDown;
  final void Function(T? value)? onChanged;
  final Widget? trailingIcon;
  final Widget? trailingClearIcon;
  final Widget? hintText;
  final Widget? noRecordText;
  final Widget Function(String searchEntry)? emptyBuilder;

  // New customizations
  final TextStyle? searchStyle;
  final Color? searchCursorColor;
  final TextAlign searchTextAlign;
  final double? elevation;
  final Color? shadowColor;
  final ShapeBorder? shape;
  final ScrollPhysics? scrollPhysics;
  final EdgeInsetsGeometry? listViewPadding;

  const DropDown({
    super.key,
    required this.controller,
    required this.showTextField,
    required this.isEnabled,
    required this.isDialogExpanded,
    this.trailingIcon,
    this.paddingValueWhileIsDialogExpanded,
    this.trailingClearIcon,
    this.onTapWhileDisableDropDown,
    this.padding,
    this.loadingWidget = const CircularProgressIndicator.adaptive(),
    this.textFieldDecoration = const InputDecoration(isDense: true),
    this.hintText,
    this.dropDownMaxHeight,
    this.paginatedRequest,
    this.noRecordText,
    this.emptyBuilder,
    this.onChanged,

    this.searchDelayDuration,
    this.hasTrailingClearIcon = true,
    this.spaceBetweenDropDownAndItemsDialog,
    this.menuDecoration,
    this.separatorBuilder,
    this.selectedItemBuilder,
    this.barrierColor,
    this.barrierDismissible,
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
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        if (isEnabled) {
          showDropdownDialog(
            context,
            controller,
            spaceBetweenDropDownAndItemsDialog: spaceBetweenDropDownAndItemsDialog,
          );
        } else {
          onTapWhileDisableDropDown?.call();
        }
      },
      child: Container(
        padding: padding ?? const EdgeInsets.all(8),

        child: Row(
          children: [
            Expanded(
              child: DropDownText(
                controller: controller,
                hintText: hintText,
                selectedItemBuilder: selectedItemBuilder,
              ),
            ),
            ValueListenableBuilder(
              valueListenable: controller.selectedItem,
              builder: (context, value, child) {
                if (value == null || !hasTrailingClearIcon) {
                  return trailingIcon ?? const Icon(Icons.keyboard_arrow_down_rounded, size: 24);
                }
                return PackageInkwellWidget(
                  padding: EdgeInsets.zero,
                  onTap: () {
                    controller.selectedItem.value = null;
                    onChanged?.call(null);
                  },
                  child: trailingClearIcon ?? const Icon(Icons.clear, color: Colors.red, size: 24),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void showDropdownDialog(
    BuildContext context,
    HighQPaginatedDropdownController<T> controller, {
    double? spaceBetweenDropDownAndItemsDialog,
  }) {
    final spaceBetweenDropDownAndItemsDialog0 = spaceBetweenDropDownAndItemsDialog ?? 0;
    var isReversed = false;
    final deviceHeight = context.deviceHeight;
    final dropdownGlobalPointBounds = controller.key.globalPaintBounds;
    final alertDialogMaxHeight = dropDownMaxHeight ?? deviceHeight * 0.35;

    final dropdownPositionFromBottom = dropdownGlobalPointBounds != null
        ? deviceHeight - dropdownGlobalPointBounds.bottom
        : null;
    var dialogPositionFromBottom = dropdownPositionFromBottom != null
        ? dropdownPositionFromBottom - alertDialogMaxHeight
        : null;
    if (dialogPositionFromBottom != null) {
      //If dialog couldn't fit the screen, reverse it
      if (dialogPositionFromBottom <= 0) {
        isReversed = true;
        final dropdownHeight = dropdownGlobalPointBounds?.height ?? 54;
        dialogPositionFromBottom += alertDialogMaxHeight + dropdownHeight - spaceBetweenDropDownAndItemsDialog0;
      } else {
        dialogPositionFromBottom -= spaceBetweenDropDownAndItemsDialog0;
      }
    }
    if (controller.items == null) {
      if (paginatedRequest != null) {
        controller.getItemsWithPaginatedRequest(page: 1, isNewSearch: true);
      }
    } else {
      controller.searchedItems.value = controller.items;
    }
    //Show the dialog
    showDialog<void>(
      context: context,
      useSafeArea: false,

      builder: (context) {
        var reCalculatePosition = dialogPositionFromBottom;
        final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
        //If keyboard pushes the dialog, recalculate the dialog's position.
        if (reCalculatePosition != null && reCalculatePosition <= keyboardHeight) {
          reCalculatePosition = (keyboardHeight - reCalculatePosition) + reCalculatePosition;
        }
        return Padding(
          padding: EdgeInsets.only(
            bottom: reCalculatePosition ?? 0,
            left: isDialogExpanded
                ? paddingValueWhileIsDialogExpanded != null
                      ? paddingValueWhileIsDialogExpanded!
                      : 16
                : dropdownGlobalPointBounds?.left ?? 0,
            right: isDialogExpanded
                ? paddingValueWhileIsDialogExpanded != null
                      ? paddingValueWhileIsDialogExpanded!
                      : 16
                : 0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: isDialogExpanded ? CrossAxisAlignment.center : CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: alertDialogMaxHeight,
                width: isDialogExpanded ? null : dropdownGlobalPointBounds?.width,
                child: DropDownCard(
                  controller: controller,
                  isReversed: isReversed,
                  showTextField: showTextField,
                  noRecordText: noRecordText,
                  emptyBuilder: emptyBuilder,
                  onChanged: onChanged,
                  paginatedRequest: paginatedRequest,

                  searchDelayDuration: searchDelayDuration,
                  textFieldDecoration: textFieldDecoration,
                  loadingWidget: loadingWidget,
                  menuDecoration: menuDecoration,
                  separatorBuilder: separatorBuilder,
                  searchStyle: searchStyle,
                  searchCursorColor: searchCursorColor,
                  searchTextAlign: searchTextAlign,
                  elevation: elevation,
                  shadowColor: shadowColor,
                  shape: shape,
                  scrollPhysics: scrollPhysics,
                  listViewPadding: listViewPadding,
                ),
              ),
            ],
          ),
        );
      },
      barrierColor: barrierColor ?? Colors.transparent,
      barrierDismissible: barrierDismissible ?? true,
    );
  }
}
