import 'package:flutter/material.dart';
import '../../high_q_paginated_drop_down.dart';

class HighQSingleDropDown<T> extends StatefulWidget {
  final List<MenuItemModel<T>>? items;
  final HighQPaginatedDropdownController<T>? controller;
  final T? initialValue;
  final bool enabled;
  final void Function(T? value)? onChanged;
  final VoidCallback? onDisabledTap;

  final SearchProps searchProps;
  final IconProps iconProps;
  final StyleProps styleProps;
  final BuilderProps<T> builderProps;

  const HighQSingleDropDown({
    super.key,
    this.items,
    this.controller,
    this.initialValue,
    this.enabled = true,
    this.onChanged,
    this.onDisabledTap,
    this.searchProps = const SearchProps(),
    this.iconProps = const IconProps(),
    this.styleProps = const StyleProps(),
    this.builderProps = const BuilderProps(),
  });

  @override
  State<HighQSingleDropDown<T>> createState() => _HighQSingleDropDownState<T>();
}

class _HighQSingleDropDownState<T> extends State<HighQSingleDropDown<T>> {
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
      showTextField: widget.searchProps.showTextField ?? true,
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
      searchStyle: widget.searchProps.style,
      searchCursorColor: widget.searchProps.cursorColor,
      searchTextAlign: widget.searchProps.textAlign ?? TextAlign.start,
      elevation: widget.styleProps.elevation,
      shadowColor: widget.styleProps.shadowColor,
      shape: widget.styleProps.shape,
      scrollPhysics: widget.styleProps.scrollPhysics,
      listViewPadding: widget.styleProps.listViewPadding,
    );

    return SizedBox(
      key: dropdownController.key,
      width: widget.styleProps.width ?? MediaQuery.of(context).size.width,
      child: widget.styleProps.backgroundDecoration?.call(dropdownWidget) ?? dropdownWidget,
    );
  }
}
