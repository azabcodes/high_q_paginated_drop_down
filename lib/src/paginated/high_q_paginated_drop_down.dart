import 'package:flutter/material.dart';
import '../../high_q_paginated_drop_down.dart';

class HighQPaginatedDropdown<T> extends StatefulWidget {
  final HighQPaginatedDropdownController<T>? controller;
  final void Function(T? value)? onChanged;
  final bool enabled;
  final MenuItemModel<T>? initialFutureValue;
  final VoidCallback? onDisabledTap;

  final PaginatedSearchProps searchProps;
  final PaginatedIconProps iconProps;
  final PaginatedStyleProps styleProps;
  final PaginatedBuilderProps<T> builderProps;
  final PaginatedRequestProps<T> requestProps;

  const HighQPaginatedDropdown({
    super.key,
    this.controller,
    this.onChanged,
    this.enabled = true,
    this.initialFutureValue,
    this.onDisabledTap,
    required this.requestProps,
    this.searchProps = const PaginatedSearchProps(),
    this.iconProps = const PaginatedIconProps(),
    this.styleProps = const PaginatedStyleProps(),
    this.builderProps = const PaginatedBuilderProps(),
  });

  @override
  State<HighQPaginatedDropdown<T>> createState() => _HighQPaginatedDropdownState<T>();
}

class _HighQPaginatedDropdownState<T> extends State<HighQPaginatedDropdown<T>> {
  late final HighQPaginatedDropdownController<T> dropdownController;

  @override
  void initState() {
    dropdownController = widget.controller ?? HighQPaginatedDropdownController<T>();
    dropdownController
      ..paginatedRequest = widget.requestProps.paginatedRequest
      ..requestItemCount = widget.requestProps.requestItemCount ?? 0;

    if (widget.initialFutureValue != null) {
      dropdownController.selectedItem.value = widget.initialFutureValue;
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
      controller: dropdownController,
      isEnabled: widget.enabled,
      onChanged: widget.onChanged,
      onTapWhileDisableDropDown: widget.onDisabledTap,
      paginatedRequest: widget.requestProps.paginatedRequest,
      ///////////////////////////////////////
      loadingWidget: widget.builderProps.loadingWidget,
      hintText: widget.builderProps.hintText,
      noRecordText: widget.builderProps.noRecordText,
      emptyBuilder: widget.builderProps.emptyBuilder,
      separatorBuilder: widget.builderProps.separatorBuilder,
      selectedItemBuilder: widget.builderProps.selectedItemBuilder,
      ///////////////////////////////////////
      showTextField: widget.searchProps.showTextField,
      textFieldDecoration: widget.searchProps.textFieldDecoration,

      searchDelayDuration: widget.searchProps.searchDelayDuration,
      ///////////////////////////////////////
      paddingValueWhileIsDialogExpanded: widget.styleProps.paddingValueWhileIsDialogExpanded,

      dropDownMaxHeight: widget.styleProps.dropDownMaxHeight,
      padding: widget.styleProps.padding,
      menuDecoration: widget.styleProps.menuDecoration,
      barrierColor: widget.styleProps.barrierColor,
      spaceBetweenDropDownAndItemsDialog: widget.styleProps.spaceBetweenDropDownAndItemsDialog,
      barrierDismissible: widget.styleProps.barrierDismissible,
      isDialogExpanded: widget.styleProps.isDialogExpanded,
      ///////////////////////////////////////
      trailingIcon: widget.iconProps.trailingIcon,
      trailingClearIcon: widget.iconProps.trailingClearIcon,
      hasTrailingClearIcon: widget.iconProps.hasTrailingClearIcon,
    );

    return SizedBox(
      key: dropdownController.key,
      width: widget.styleProps.width ?? MediaQuery.of(context).size.width,
      child: widget.styleProps.backgroundDecoration?.call(dropdownWidget) ?? dropdownWidget,
    );
  }
}
