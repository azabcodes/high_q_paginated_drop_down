import 'dart:async';
import 'package:flutter/material.dart';
import '../high_q_paginated_drop_down.dart';

class HighQPaginatedDropdown<T> extends StatefulWidget {
  final bool isEnabled;
  final bool showTextField;
  final bool isDialogExpanded;
  final bool hasTrailingClearIcon;
  final double? dropDownMaxHeight;
  final double? paddingValueWhileIsDialogExpanded;
  final double? width;
  final double? spaceBetweenDropDownAndItemsDialog;
  final InputDecoration? textFieldDecoration;
  final Duration? searchDelayDuration;
  final EdgeInsetsGeometry? padding;
  final Future<List<MenuItemModel<T>>?> Function(int page, String? searchText)?
  paginatedRequest;
  final int? requestItemCount;
  final List<MenuItemModel<T>>? items;
  final PaginatedSearchDropdownController<T>? controller;
  final MenuItemModel<T>? initialFutureValue;
  final String? searchHintText;
  final T? initialValue;
  final VoidCallback? onTapWhileDisableDropDown;
  final void Function(T? value)? onChanged;

  final Widget? hintText;
  final Widget? loadingWidget;

  final Widget? noRecordText;

  final Widget? trailingIcon;

  final Widget? trailingClearIcon;

  final Widget? leadingIcon;

  final Widget Function(Widget child)? backgroundDecoration;
  final Decoration? menuDecoration;
  final Widget Function(BuildContext context, int index)? separatorBuilder;
  final Widget Function(BuildContext context, T? item)? selectedItemBuilder;
  final Color? barrierColor;
  final bool? barrierDismissible;

  const HighQPaginatedDropdown({
    Key? key,
    PaginatedSearchDropdownController<T>? controller,
    Widget? hintText,
    Widget? loadingWidget,
    Widget Function(Widget)? backgroundDecoration,
    InputDecoration? textFieldDecoration,
    String? searchHintText,
    Widget? noRecordText,
    double? dropDownMaxHeight,
    EdgeInsetsGeometry? padding,
    Widget? trailingIcon,
    Widget? trailingClearIcon,
    Widget? leadingIcon,
    void Function(T?)? onChanged,
    List<MenuItemModel<T>>? items,
    T? value,
    bool isEnabled = true,
    VoidCallback? onTapWhileDisableDropDown,
    double? width,
    bool isDialogExpanded = true,
    bool hasTrailingClearIcon = true,
    bool showTextField = true,
    double? spaceBetweenDropDownAndItemsDialog,
    Duration? searchDelayDuration,
    double? paddingValueWhileIsDialogExpanded,
    MenuItemModel<T>? initialValue,
    Decoration? decoration,
    Decoration? menuDecoration,
    Widget Function(BuildContext, int)? separatorBuilder,
    Widget Function(BuildContext, T?)? selectedItemBuilder,
    Color? barrierColor,
    bool? barrierDismissible,
  }) : this._(
         key: key,
         hintText: hintText,
         loadingWidget:
             loadingWidget ?? const CircularProgressIndicator.adaptive(),
         controller: controller,
         backgroundDecoration: backgroundDecoration,
         searchHintText: searchHintText,
         noRecordText: noRecordText,
         dropDownMaxHeight: dropDownMaxHeight,
         padding: padding,
         trailingIcon: trailingIcon,
         trailingClearIcon: trailingClearIcon,
         leadingIcon: leadingIcon,
         onChanged: onChanged,
         items: items,
         initialValue: value,
         isEnabled: isEnabled,
         onTapWhileDisableDropDown: onTapWhileDisableDropDown,
         width: width,
         showTextField: showTextField,
         textFieldDecoration: textFieldDecoration,
         isDialogExpanded: isDialogExpanded,
         hasTrailingClearIcon: hasTrailingClearIcon,
         spaceBetweenDropDownAndItemsDialog: spaceBetweenDropDownAndItemsDialog,
         paddingValueWhileIsDialogExpanded: paddingValueWhileIsDialogExpanded,
         searchDelayDuration: searchDelayDuration,
         initialFutureValue: initialValue,

         menuDecoration: menuDecoration,

         separatorBuilder: separatorBuilder,
         selectedItemBuilder: selectedItemBuilder,
         barrierColor: barrierColor,
         barrierDismissible: barrierDismissible,
       );

  const HighQPaginatedDropdown.paginated({
    required Future<List<MenuItemModel<T>>?> Function(int, String?)?
    paginatedRequest,
    int? requestItemCount,
    Key? key,
    InputDecoration? textFieldDecoration,
    PaginatedSearchDropdownController<T>? controller,
    Widget? loadingWidget,
    Widget? hintText,
    Widget Function(Widget)? backgroundDecoration,
    String? searchHintText,
    Widget? noRecordText,
    double? dropDownMaxHeight,
    EdgeInsetsGeometry? padding,
    Widget? trailingIcon,
    Widget? trailingClearIcon,
    Widget? leadingIcon,
    void Function(T?)? onChanged,
    bool isEnabled = true,
    bool showTextField = true,
    VoidCallback? onTapWhileDisableDropDown,
    Duration? searchDelayDuration,
    double? width,
    double? paddingValueWhileIsDialogExpanded,
    bool isDialogExpanded = true,
    bool hasTrailingClearIcon = true,
    MenuItemModel<T>? initialValue,
    double? spaceBetweenDropDownAndItemsDialog,

    Decoration? menuDecoration,
    Widget Function(BuildContext, int)? separatorBuilder,
    Widget Function(BuildContext, T?)? selectedItemBuilder,
    Color? barrierColor,
    bool? barrierDismissible,
  }) : this._(
         key: key,
         controller: controller,
         textFieldDecoration: textFieldDecoration,
         paddingValueWhileIsDialogExpanded: paddingValueWhileIsDialogExpanded,
         loadingWidget:
             loadingWidget ?? const CircularProgressIndicator.adaptive(),
         paginatedRequest: paginatedRequest,
         requestItemCount: requestItemCount,
         hintText: hintText,
         backgroundDecoration: backgroundDecoration,
         searchHintText: searchHintText,
         noRecordText: noRecordText,
         dropDownMaxHeight: dropDownMaxHeight,
         padding: padding,
         trailingIcon: trailingIcon,
         trailingClearIcon: trailingClearIcon,
         leadingIcon: leadingIcon,
         onChanged: onChanged,
         isEnabled: isEnabled,
         showTextField: showTextField,
         onTapWhileDisableDropDown: onTapWhileDisableDropDown,
         searchDelayDuration: searchDelayDuration,
         width: width,
         isDialogExpanded: isDialogExpanded,
         hasTrailingClearIcon: hasTrailingClearIcon,
         initialFutureValue: initialValue,
         spaceBetweenDropDownAndItemsDialog: spaceBetweenDropDownAndItemsDialog,
         menuDecoration: menuDecoration,

         separatorBuilder: separatorBuilder,
         selectedItemBuilder: selectedItemBuilder,
         barrierColor: barrierColor,
         barrierDismissible: barrierDismissible,
       );

  const HighQPaginatedDropdown._({
    super.key,
    this.controller,
    this.showTextField = true,
    this.loadingWidget,
    this.hintText,
    this.textFieldDecoration = const InputDecoration(),
    this.paddingValueWhileIsDialogExpanded,
    this.backgroundDecoration,
    this.searchHintText,
    this.noRecordText,
    this.dropDownMaxHeight,
    this.padding,
    this.trailingIcon,
    this.trailingClearIcon,
    this.leadingIcon,
    this.onChanged,
    this.items,
    this.initialValue,
    this.initialFutureValue,
    this.isEnabled = true,
    this.onTapWhileDisableDropDown,
    this.paginatedRequest,
    this.requestItemCount,
    this.searchDelayDuration,
    this.width,
    this.isDialogExpanded = true,
    this.hasTrailingClearIcon = true,
    this.spaceBetweenDropDownAndItemsDialog,
    this.menuDecoration,
    this.separatorBuilder,
    this.selectedItemBuilder,
    this.barrierColor,
    this.barrierDismissible,
  });

  @override
  State<HighQPaginatedDropdown<T>> createState() =>
      _HighQPaginatedDropdownState<T>();
}

class _HighQPaginatedDropdownState<T> extends State<HighQPaginatedDropdown<T>> {
  late final PaginatedSearchDropdownController<T> dropdownController;

  @override
  void initState() {
    dropdownController =
        widget.controller ?? PaginatedSearchDropdownController<T>();
    dropdownController
      ..paginatedRequest = widget.paginatedRequest
      ..requestItemCount = widget.requestItemCount ?? 0
      ..items = widget.items
      ..searchedItems.value = widget.items;
    if (widget.initialFutureValue != null) {
      dropdownController.selectedItem.value = widget.initialFutureValue;
    }
    for (final element in widget.items ?? <MenuItemModel<T>>[]) {
      if (element.value == widget.initialValue) {
        dropdownController.selectedItem.value = element;
        return;
      }
    }

    if (dropdownController.paginatedRequest == null) return;
    super.initState();
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      dropdownController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dropdownWidget = DropDown(
      loadingWidget: widget.loadingWidget!,
      controller: dropdownController,
      showTextField: widget.showTextField,
      isEnabled: widget.isEnabled,
      paddingValueWhileIsDialogExpanded:
          widget.paddingValueWhileIsDialogExpanded,
      onTapWhileDisableDropDown: widget.onTapWhileDisableDropDown,
      dropDownMaxHeight: widget.dropDownMaxHeight,
      hintText: widget.hintText,
      leadingIcon: widget.leadingIcon,
      padding: widget.padding,
      noRecordText: widget.noRecordText,
      onChanged: widget.onChanged,
      paginatedRequest: widget.paginatedRequest,
      searchHintText: widget.searchHintText,
      trailingIcon: widget.trailingIcon,
      trailingClearIcon: widget.trailingClearIcon,
      searchDelayDuration: widget.searchDelayDuration,
      isDialogExpanded: widget.isDialogExpanded,
      hasTrailingClearIcon: widget.hasTrailingClearIcon,
      spaceBetweenDropDownAndItemsDialog:
          widget.spaceBetweenDropDownAndItemsDialog,
      textFieldDecoration: widget.textFieldDecoration,
      menuDecoration: widget.menuDecoration,

      separatorBuilder: widget.separatorBuilder,
      selectedItemBuilder: widget.selectedItemBuilder,
      barrierColor: widget.barrierColor,
      barrierDismissible: widget.barrierDismissible,
    );

    return SizedBox(
      key: dropdownController.key,
      width: widget.width ?? MediaQuery.of(context).size.width,
      child:
          widget.backgroundDecoration?.call(dropdownWidget) ?? dropdownWidget,
    );
  }
}
