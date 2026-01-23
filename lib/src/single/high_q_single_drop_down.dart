import 'package:flutter/material.dart';
import '../../high_q_paginated_drop_down.dart';

class HighQDropDown<T> extends StatefulWidget {
  final List<MenuItemModel<T>>? items;
  final HighQPaginatedDropdownController<T>? controller;
  final T? initialValue;
  final bool enabled;
  final void Function(T? value)? onChanged;
  final VoidCallback? onDisabledTap;

  final PaginatedSearchProps searchProps;
  final PaginatedIconProps iconProps;
  final PaginatedStyleProps styleProps;
  final PaginatedBuilderProps<T> builderProps;

  const HighQDropDown({
    super.key,
    this.items,
    this.controller,
    this.initialValue,
    this.enabled = true,
    this.onChanged,
    this.onDisabledTap,
    this.searchProps = const PaginatedSearchProps(),
    this.iconProps = const PaginatedIconProps(),
    this.styleProps = const PaginatedStyleProps(),
    this.builderProps = const PaginatedBuilderProps(),
  });

  @override
  State<HighQDropDown<T>> createState() => _HighQDropDownState<T>();
}

class _HighQDropDownState<T> extends State<HighQDropDown<T>> {
  late final HighQPaginatedDropdownController<T> dropdownController;

  @override
  void initState() {
    dropdownController = widget.controller ?? HighQPaginatedDropdownController<T>();
    dropdownController
      ..items = widget.items
      ..searchedItems.value = widget.items;

    for (final element in widget.items ?? <MenuItemModel<T>>[]) {
      if (element.value == widget.initialValue) {
        dropdownController.selectedItem.value = element;
        return;
      }
    }

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
      loadingWidget: widget.builderProps.loadingWidget,
      controller: dropdownController,
      showTextField: widget.searchProps.showTextField,
      isEnabled: widget.enabled,
      paddingValueWhileIsDialogExpanded: widget.styleProps.paddingValueWhileIsDialogExpanded,
      onTapWhileDisableDropDown: widget.onDisabledTap,
      dropDownMaxHeight: widget.styleProps.dropDownMaxHeight,
      hintText: widget.builderProps.hintText,
      padding: widget.styleProps.padding,
      noRecordText: widget.builderProps.noRecordText,
      emptyBuilder: widget.builderProps.emptyBuilder,
      onChanged: widget.onChanged,

      trailingIcon: widget.iconProps.trailingIcon,
      trailingClearIcon: widget.iconProps.trailingClearIcon,
      searchDelayDuration: widget.searchProps.searchDelayDuration,
      isDialogExpanded: widget.styleProps.isDialogExpanded,
      hasTrailingClearIcon: widget.iconProps.hasTrailingClearIcon,
      spaceBetweenDropDownAndItemsDialog: widget.styleProps.spaceBetweenDropDownAndItemsDialog,
      textFieldDecoration: widget.searchProps.textFieldDecoration,
      menuDecoration: widget.styleProps.menuDecoration,

      separatorBuilder: widget.builderProps.separatorBuilder,
      selectedItemBuilder: widget.builderProps.selectedItemBuilder,
      barrierColor: widget.styleProps.barrierColor,
      barrierDismissible: widget.styleProps.barrierDismissible,
    );

    return SizedBox(
      key: dropdownController.key,
      width: widget.styleProps.width ?? MediaQuery.of(context).size.width,
      child: widget.styleProps.backgroundDecoration?.call(dropdownWidget) ?? dropdownWidget,
    );
  }
}
