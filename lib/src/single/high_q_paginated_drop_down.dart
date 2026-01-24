import 'package:flutter/material.dart';
import '../../high_q_paginated_drop_down.dart';

class HighQPaginatedDropdown<T> extends StatefulWidget {
  final HighQPaginatedDropdownController<T>? controller;
  final void Function(T? value)? onChanged;
  final bool enabled;
  final MenuItemModel<T>? initialFutureValue;
  final VoidCallback? onDisabledTap;

  final SearchProps searchProps;
  final IconProps iconProps;
  final StyleProps styleProps;
  final BuilderProps<T> builderProps;
  final PaginatedRequestProps<T> requestProps;

  const HighQPaginatedDropdown({
    super.key,
    this.controller,
    this.onChanged,
    this.enabled = true,
    this.initialFutureValue,
    this.onDisabledTap,
    required this.requestProps,
    this.searchProps = const SearchProps(),
    this.iconProps = const IconProps(),
    this.styleProps = const StyleProps(),
    this.builderProps = const BuilderProps(),
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
      showTextField: widget.searchProps.showTextField ?? true,
      textFieldDecoration: widget.searchProps.textFieldDecoration,
      searchDelayDuration: widget.searchProps.searchDelayDuration,
      searchStyle: widget.searchProps.style,
      searchCursorColor: widget.searchProps.cursorColor,
      searchTextAlign: widget.searchProps.textAlign ?? TextAlign.start,
      ///////////////////////////////////////
      paddingValueWhileIsDialogExpanded: widget.styleProps.paddingValueWhileIsDialogExpanded,

      dropDownMaxHeight: widget.styleProps.dropDownMaxHeight,
      padding: widget.styleProps.padding,
      menuDecoration: widget.styleProps.menuDecoration,
      barrierColor: widget.styleProps.barrierColor,
      spaceBetweenDropDownAndItemsDialog: widget.styleProps.spaceBetweenDropDownAndItemsDialog,
      barrierDismissible: widget.styleProps.barrierDismissible,
      isDialogExpanded: widget.styleProps.isDialogExpanded,
      elevation: widget.styleProps.elevation,
      shadowColor: widget.styleProps.shadowColor,
      shape: widget.styleProps.shape,
      scrollPhysics: widget.styleProps.scrollPhysics,
      listViewPadding: widget.styleProps.listViewPadding,
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
