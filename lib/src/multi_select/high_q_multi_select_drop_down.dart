import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../high_q_paginated_drop_down.dart';

class HighQMultiSelectDropDown<T> extends StatefulWidget {
  final ItemsLogicProps<T> itemsLogicProps;
  final FilterAndCompareProps<T> filterAndCompareProps;
  final DropDownDecoratorProps dropdownDecorator;
  final SelectedItemDecorationPros selectedItemDecorationPros;
  final ConfirmButtonProps confirmButtonProps;
  final CancelButtonProps? cancelButtonProps;
  final ClearButtonProps clearButtonProps;
  final Widget? loadingWidget;
  final DropdownButtonProps dropdownButtonProps;
  final ValidatorProps<T> validatorProps;
  final PopupPropsMultiSelection<T> popupProps;
  final MethodLogicProps<T> methodLogicProps;
  final String moreText;
  final bool makeButtonsInRow;
  final String lessText;
  final MultiSelectController<T>? controller;
  final int maxDisplayCount;
  final ValueChanged<List<T>>? onChanged;
  final FormFieldSetter<List<T>>? onSavedMultiSelection;
  final BeforeChangeMultiSelection<T>? onBeforeChangeMultiSelection;
  final Function(String)? textFieldOnChanged;
  final BeforePopupOpeningMultiSelection<T>? onBeforePopupOpeningMultiSelection;

  final bool enabled;

  final SearchProps searchProps;
  final StyleProps styleProps;

  HighQMultiSelectDropDown({
    super.key,
    this.moreText = 'Show more',
    this.lessText = 'Show less',
    this.maxDisplayCount = 3,
    this.controller,
    this.loadingWidget,
    this.makeButtonsInRow = false,
    this.dropdownDecorator = const DropDownDecoratorProps(),
    this.clearButtonProps = const ClearButtonProps(),
    this.dropdownButtonProps = const DropdownButtonProps(),
    this.confirmButtonProps = const ConfirmButtonProps(),
    this.cancelButtonProps,
    this.selectedItemDecorationPros = const SelectedItemDecorationPros(),
    this.itemsLogicProps = const ItemsLogicProps(),
    this.validatorProps = const ValidatorProps(),
    this.filterAndCompareProps = const FilterAndCompareProps(),
    this.popupProps = const PopupPropsMultiSelection.menu(),
    this.methodLogicProps = const MethodLogicProps(),
    this.enabled = true,
    this.searchProps = const SearchProps(),
    this.styleProps = const StyleProps(),
  }) : assert(
         !popupProps.showSelectedItems || T == String || filterAndCompareProps.compareFn != null,
       ),
       onChanged = methodLogicProps.onChanged,
       textFieldOnChanged = popupProps.textFieldOnChanged,
       onBeforePopupOpeningMultiSelection = methodLogicProps.onBeforePopupOpening,
       onSavedMultiSelection = methodLogicProps.onSaved,
       onBeforeChangeMultiSelection = methodLogicProps.onBeforeChange;

  @override
  HighQMultiSelectDropDownState<T> createState() => HighQMultiSelectDropDownState<T>();
}

class HighQMultiSelectDropDownState<T> extends State<HighQMultiSelectDropDown<T>> {
  final ValueNotifier<List<T>> _selectedItemsNotifier = ValueNotifier([]);
  final ValueNotifier<bool> _isFocused = ValueNotifier(false);
  final _popupStateKey = GlobalKey<SelectionWidgetState<T>>();
  bool _showAllItems = false;

  @override
  void initState() {
    super.initState();
    _selectedItemsNotifier.value = List.from(
      widget.itemsLogicProps.initialSelectedItems,
    );
    _showAllItems = false;
    // Initialize the controller
    if (widget.controller != null) {
      widget.controller!.clearSelectionCallback = _clearSelection;
      widget.controller!.getSelectedItemsCallback = () => getSelectedItems;
    }
  }

  @override
  void didUpdateWidget(HighQMultiSelectDropDown<T> oldWidget) {
    List<T> oldSelectedItems = oldWidget.itemsLogicProps.initialSelectedItems;

    List<T> newSelectedItems = widget.itemsLogicProps.initialSelectedItems;

    if (!listEquals(oldSelectedItems, newSelectedItems)) {
      _selectedItemsNotifier.value = List.from(newSelectedItems);
    }

    if (widget.popupProps.containerBuilder != oldWidget.popupProps.containerBuilder) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        _popupStateKey.currentState?.setState(() {});
      });
    }

    super.didUpdateWidget(oldWidget);
  }

  void _clearSelection() {
    setState(() {
      _selectedItemsNotifier.value = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<T?>>(
      valueListenable: _selectedItemsNotifier,
      builder: (context, data, wt) {
        return IgnorePointer(
          ignoring: !widget.enabled,
          child: InkWell(
            onTap: () {
              _selectSearchMode();
            },
            child: _formField(),
          ),
        );
      },
    );
  }

  List<T> _itemToList(T? item) {
    List<T?> nullableList = List.filled(1, item);
    return nullableList.whereType<T>().toList();
  }

  Widget _defaultSelectedItemWidget() {
    final maxDisplayCount = widget.maxDisplayCount;

    Widget defaultItemMultiSelectionMode(T item) {
      return Container(
        padding: widget.selectedItemDecorationPros.selectedItemBoxPadding ?? EdgeInsets.only(left: 8, right: 1),
        margin:
            widget.selectedItemDecorationPros.selectedItemBoxMargin ?? EdgeInsets.symmetric(horizontal: 2, vertical: 1),
        decoration:
            widget.selectedItemDecorationPros.selectedItemBoxDecoration ??
            BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Theme.of(context).primaryColorLight,
            ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Padding(
                padding: widget.selectedItemDecorationPros.selectedItemTextPadding ?? EdgeInsets.zero,
                child: Text(
                  _selectedItemAsString(item),
                  style:
                      widget.selectedItemDecorationPros.selectedItemTextStyle ?? Theme.of(context).textTheme.titleSmall,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            Padding(
              padding: widget.selectedItemDecorationPros.removeItemWidgetPadding ?? EdgeInsets.zero,
              child: GestureDetector(
                onTap: () {
                  removeItem(item);
                },
                child: widget.selectedItemDecorationPros.removeItemWidget,
              ),
            ),
          ],
        ),
      );
    }

    List<Widget> buildSelectedItemWidgets(List<T> items) {
      if (items.length <= maxDisplayCount) {
        return items.map((e) => defaultItemMultiSelectionMode(e)).toList();
      } else {
        final displayedItems = items.take(maxDisplayCount).toList();
        final remainingItems = items.skip(maxDisplayCount).toList();

        return [
          ...displayedItems.map((e) => defaultItemMultiSelectionMode(e)),
          // if (remainingItems.isNotEmpty)
          //   GestureDetector(
          //     onTap: () {
          //       setState(() {
          //         _showAllItems = !_showAllItems;
          //       });
          //     },
          //     child: Container(
          //       padding: EdgeInsets.symmetric(horizontal: 8),
          //       child: Text(
          //         _showAllItems
          //             ? widget.lessText
          //             : '+${items.length - maxDisplayCount} ${widget.moreText}',
          //         style: widget.selectedItemDecorationPros.moreTextStyle ??
          //             Theme.of(context).textTheme.titleSmall,
          //       ),
          //     ),
          //   ),
          if (_showAllItems) ...remainingItems.map((e) => defaultItemMultiSelectionMode(e)),
        ];
      }
    }

    final selectedItems = getSelectedItems;
    final itemWidgets = buildSelectedItemWidgets(selectedItems);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(children: itemWidgets),
        if (selectedItems.isNotEmpty && selectedItems.length > maxDisplayCount)
          GestureDetector(
            onTap: () {
              setState(() {
                _showAllItems = !_showAllItems;
              });
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                _showAllItems ? widget.lessText : '+${selectedItems.length - maxDisplayCount} ${widget.moreText}',
                style: widget.selectedItemDecorationPros.moreTextStyle ?? Theme.of(context).textTheme.titleSmall,
              ),
            ),
          ),
      ],
    );
  }

  Widget _formField() {
    return _formFieldMultiSelection();
  }

  Widget _formFieldMultiSelection() {
    return FormField<List<T>>(
      enabled: widget.enabled,
      onSaved: widget.onSavedMultiSelection,
      validator: widget.validatorProps.validator,
      autovalidateMode: widget.validatorProps.autoValidateMode,
      initialValue: widget.itemsLogicProps.initialSelectedItems,
      builder: (FormFieldState<List<T>> state) {
        if (state.value != getSelectedItems) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) {
              state.didChange(getSelectedItems);
            }
          });
        }
        return ValueListenableBuilder<bool>(
          valueListenable: _isFocused,
          builder: (context, isFocused, w) {
            return InputDecorator(
              baseStyle: widget.dropdownDecorator.baseStyle,
              textAlign: widget.dropdownDecorator.textAlign,
              textAlignVertical: widget.dropdownDecorator.textAlignVertical,
              isEmpty: getSelectedItems.isEmpty,
              isFocused: isFocused,
              decoration: _manageDropdownDecoration(state),
              child: _defaultSelectedItemWidget(),
            );
          },
        );
      },
    );
  }

  InputDecoration _manageDropdownDecoration(FormFieldState state) {
    return (widget.dropdownDecorator.multiSelectDropDownDecoration ??
            const InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(12, 12, 0, 0),
              border: OutlineInputBorder(),
            ))
        .applyDefaults(Theme.of(state.context).inputDecorationTheme)
        .copyWith(
          enabled: widget.enabled,
          suffixIcon: _manageSuffixIcons(),
          //widget.filterAndCompareProps.filterIcon ?? _manageSuffixIcons(),
          errorText: state.errorText,
        );
  }

  String _selectedItemAsString(T? data) {
    if (data == null) {
      return "";
    } else if (widget.itemsLogicProps.itemAsString != null) {
      return widget.itemsLogicProps.itemAsString!(data);
    } else {
      return data.toString();
    }
  }

  Widget _manageSuffixIcons() {
    clearButtonPressed() => clearAllSelected();
    dropdownButtonPressed() => _selectSearchMode();
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        if (widget.clearButtonProps.isVisible && getSelectedItems.isNotEmpty)
          IconButton(
            style: widget.clearButtonProps.style,
            isSelected: widget.clearButtonProps.isSelected,
            selectedIcon: widget.clearButtonProps.selectedIcon,
            onPressed: widget.clearButtonProps.onPressed ?? clearButtonPressed,
            icon: widget.clearButtonProps.icon,
            constraints: widget.clearButtonProps.constraints,
            hoverColor: widget.clearButtonProps.hoverColor,
            highlightColor: widget.clearButtonProps.highlightColor,
            splashColor: widget.clearButtonProps.splashColor,
            color: widget.clearButtonProps.color,
            focusColor: widget.clearButtonProps.focusColor,
            iconSize: widget.clearButtonProps.iconSize,
            padding: widget.clearButtonProps.padding,
            splashRadius: widget.clearButtonProps.splashRadius,
            alignment: widget.clearButtonProps.alignment,
            autofocus: widget.clearButtonProps.autofocus,
            disabledColor: widget.clearButtonProps.disabledColor,
            enableFeedback: widget.clearButtonProps.enableFeedback,
            focusNode: widget.clearButtonProps.focusNode,
            mouseCursor: widget.clearButtonProps.mouseCursor,
            tooltip: widget.clearButtonProps.tooltip,
            visualDensity: widget.clearButtonProps.visualDensity,
          ),
        if (widget.dropdownButtonProps.isVisible)
          IconButton(
            style: widget.dropdownButtonProps.style,
            isSelected: widget.dropdownButtonProps.isSelected,
            selectedIcon: widget.dropdownButtonProps.selectedIcon,
            onPressed: widget.dropdownButtonProps.onPressed ?? dropdownButtonPressed,
            icon: widget.dropdownButtonProps.icon,
            constraints: widget.dropdownButtonProps.constraints,
            hoverColor: widget.dropdownButtonProps.hoverColor,
            highlightColor: widget.dropdownButtonProps.highlightColor,
            splashColor: widget.dropdownButtonProps.splashColor,
            color: widget.dropdownButtonProps.color,
            focusColor: widget.dropdownButtonProps.focusColor,
            iconSize: widget.dropdownButtonProps.iconSize,
            padding: widget.dropdownButtonProps.padding,
            splashRadius: widget.dropdownButtonProps.splashRadius,
            alignment: widget.dropdownButtonProps.alignment,
            autofocus: widget.dropdownButtonProps.autofocus,
            disabledColor: widget.dropdownButtonProps.disabledColor,
            enableFeedback: widget.dropdownButtonProps.enableFeedback,
            focusNode: widget.dropdownButtonProps.focusNode,
            mouseCursor: widget.dropdownButtonProps.mouseCursor,
            tooltip: widget.dropdownButtonProps.tooltip,
            visualDensity: widget.dropdownButtonProps.visualDensity,
          ),
      ],
    );
  }

  RelativeRect _position(RenderBox popupButtonObject, RenderBox overlay) {
    return RelativeRect.fromSize(
      Rect.fromPoints(
        popupButtonObject.localToGlobal(
          popupButtonObject.size.bottomLeft(Offset.zero),
          ancestor: overlay,
        ),
        popupButtonObject.localToGlobal(
          popupButtonObject.size.bottomRight(Offset.zero),
          ancestor: overlay,
        ),
      ),
      Size(overlay.size.width, overlay.size.height),
    );
  }

  Future _openSelectDialog() {
    final effectivePopupProps = _getEffectivePopupProps();
    return showGeneralDialog(
      context: context,
      barrierDismissible: effectivePopupProps.dialogProps.barrierDismissible,
      barrierLabel: effectivePopupProps.dialogProps.barrierLabel,
      transitionDuration: effectivePopupProps.dialogProps.transitionDuration,
      barrierColor: effectivePopupProps.dialogProps.barrierColor ?? Colors.black54,
      useRootNavigator: effectivePopupProps.dialogProps.useRootNavigator,
      anchorPoint: effectivePopupProps.dialogProps.anchorPoint,
      transitionBuilder: effectivePopupProps.dialogProps.transitionBuilder,
      pageBuilder: (context, animation, secondaryAnimation) {
        return AlertDialog(
          buttonPadding: effectivePopupProps.dialogProps.buttonPadding,
          actionsOverflowButtonSpacing: effectivePopupProps.dialogProps.actionsOverflowButtonSpacing,
          insetPadding: effectivePopupProps.dialogProps.insetPadding,
          actionsPadding: effectivePopupProps.dialogProps.actionsPadding,
          actionsOverflowDirection: effectivePopupProps.dialogProps.actionsOverflowDirection,
          actionsOverflowAlignment: effectivePopupProps.dialogProps.actionsOverflowAlignment,
          actionsAlignment: effectivePopupProps.dialogProps.actionsAlignment,
          actions: effectivePopupProps.dialogProps.actions,
          alignment: effectivePopupProps.dialogProps.alignment,
          clipBehavior: effectivePopupProps.dialogProps.clipBehavior,
          elevation: effectivePopupProps.dialogProps.elevation,
          contentPadding: effectivePopupProps.dialogProps.contentPadding,
          shape: effectivePopupProps.dialogProps.shape,
          backgroundColor: effectivePopupProps.dialogProps.backgroundColor,
          semanticLabel: effectivePopupProps.dialogProps.semanticLabel,
          content: _popupWidgetInstance(),
        );
      },
    );
  }

  Future _openModalBottomSheet() {
    final effectivePopupProps = _getEffectivePopupProps();
    final sheetTheme = Theme.of(context).bottomSheetTheme;
    return showModalBottomSheet<T>(
      context: context,
      useSafeArea: effectivePopupProps.modalBottomSheetProps.useSafeArea,
      barrierColor: effectivePopupProps.modalBottomSheetProps.barrierColor,
      backgroundColor:
          effectivePopupProps.modalBottomSheetProps.backgroundColor ??
          sheetTheme.modalBackgroundColor ??
          sheetTheme.backgroundColor ??
          Colors.white,
      isDismissible: effectivePopupProps.modalBottomSheetProps.barrierDismissible,
      isScrollControlled: effectivePopupProps.modalBottomSheetProps.isScrollControlled,
      enableDrag: effectivePopupProps.modalBottomSheetProps.enableDrag,
      clipBehavior: effectivePopupProps.modalBottomSheetProps.clipBehavior,
      elevation: effectivePopupProps.modalBottomSheetProps.elevation,
      shape: effectivePopupProps.modalBottomSheetProps.shape,
      anchorPoint: effectivePopupProps.modalBottomSheetProps.anchorPoint,
      useRootNavigator: effectivePopupProps.modalBottomSheetProps.useRootNavigator,
      transitionAnimationController: effectivePopupProps.modalBottomSheetProps.animation,
      constraints: effectivePopupProps.modalBottomSheetProps.constraints,
      builder: (ctx) => _popupWidgetInstance(),
    );
  }

  Future _openMenu() {
    final effectivePopupProps = _getEffectivePopupProps();
    // Here we get the render object of our physical button, later to get its size & position
    final popupButtonObject = context.findRenderObject() as RenderBox;
    // Get the render object of the overlay used in `Navigator` / `MaterialApp`, i.e. screen size reference
    var overlay = Overlay.of(context).context.findRenderObject() as RenderBox;

    return showCustomMenu<T>(
      menuModeProps: effectivePopupProps.menuProps,
      context: context,
      position: (effectivePopupProps.menuProps.positionCallback ?? _position)(
        popupButtonObject,
        overlay,
      ),
      child: _popupWidgetInstance(),
    );
  }

  Widget _popupWidgetInstance() {
    final effectivePopupProps = _getEffectivePopupProps();
    return SelectionWidget<T>(
      key: _popupStateKey,
      makeButtonsInRow: widget.makeButtonsInRow,
      popupProps: effectivePopupProps,
      items: widget.itemsLogicProps.items,
      itemAsString: widget.itemsLogicProps.itemAsString,
      asyncItems: widget.itemsLogicProps.asyncItems,
      afterPopTheDialog: widget.confirmButtonProps.afterPopTheDialog,
      confirmText: widget.confirmButtonProps.confirmText,
      confirmButtonStyle: widget.confirmButtonProps.confirmButtonStyle,
      cancelButtonProps: widget.cancelButtonProps,
      confirmTextTextStyle: widget.confirmButtonProps.confirmTextTextStyle,
      confirmButtonBuilder: widget.confirmButtonProps.builder,
      confirmButtonPadding: widget.confirmButtonProps.confirmButtonPadding,
      defaultSelectedItems: List.from(getSelectedItems),
      compareFn: widget.filterAndCompareProps.compareFn,
      filterFn: widget.filterAndCompareProps.filterFn,
      clearButtonProps: widget.clearButtonProps,
      loadingWidget: widget.loadingWidget,
      clearAllSelected: clearAllSelected,
      onChanged: _handleOnChangeSelectedItems,
    );
  }

  // Helper to merge PopupProps with new searchProps and styleProps
  PopupPropsMultiSelection<T> _getEffectivePopupProps() {
    final original = widget.popupProps;

    // Merge SearchFieldProps
    var searchFieldProps = original.searchFieldProps.copyWith(
      style: widget.searchProps.style,
      cursorColor: widget.searchProps.cursorColor,
      textAlign: widget.searchProps.textAlign ?? original.searchFieldProps.textAlign,
      decoration: widget.searchProps.textFieldDecoration,
    );

    // Merge ListViewProps
    var listViewProps = original.listViewProps.copyWith(
      physics: widget.styleProps.scrollPhysics,
      padding: widget.styleProps.listViewPadding,
    );

    // Merge MenuProps
    var menuProps = original.menuProps.copyWith(
      elevation: widget.styleProps.elevation,
      shadowColor: widget.styleProps.shadowColor,
      shape: widget.styleProps.shape,
    );

    // Merge DialogProps
    var dialogProps = original.dialogProps.copyWith(
      elevation: widget.styleProps.elevation,
      shape: widget.styleProps.shape,
    );

    // Merge ModalBottomSheetProps
    var modalBottomSheetProps = original.modalBottomSheetProps.copyWith(
      elevation: widget.styleProps.elevation,
      shape: widget.styleProps.shape,
    );

    // Since PopupPropsMultiSelection doesn't have a copyWith, we have to construct it
    // based on original mode.

    if (original.mode == Mode.menu) {
      return PopupPropsMultiSelection.menu(
        title: original.title,
        fit: original.fit,
        showSearchBox: widget.searchProps.showTextField ?? original.showSearchBox,
        searchFieldProps: searchFieldProps,
        menuProps: menuProps,
        favoriteItemProps: original.favoriteItemProps,
        scrollbarProps: original.scrollbarProps,
        listViewProps: listViewProps,
        searchDelay: original.searchDelay,
        onDismissed: original.onDismissed,
        emptyBuilder: original.emptyBuilder,
        textFieldOnChanged: original.textFieldOnChanged,
        itemBuilder: original.itemBuilder,
        errorBuilder: original.errorBuilder,
        loadingBuilder: original.loadingBuilder,
        showSelectedItems: original.showSelectedItems,
        disabledItemFn: original.disabledItemFn,
        isFilterOnline: original.isFilterOnline,
        containerBuilder: original.containerBuilder,
        constraints: original.constraints,
        interceptCallBacks: original.interceptCallBacks,
        onItemAdded: original.onItemAdded,
        onItemRemoved: original.onItemRemoved,
        selectionWidget: original.selectionWidget,
        validationWidgetBuilder: original.validationWidgetBuilder,
        textDirection: original.textDirection,
      );
    } else if (original.mode == Mode.dialog) {
      return PopupPropsMultiSelection.dialog(
        title: original.title,
        fit: original.fit,
        showSearchBox: widget.searchProps.showTextField ?? original.showSearchBox,
        searchFieldProps: searchFieldProps,
        scrollbarProps: original.scrollbarProps,
        listViewProps: listViewProps,
        favoriteItemProps: original.favoriteItemProps,
        dialogProps: dialogProps,
        searchDelay: original.searchDelay,
        onDismissed: original.onDismissed,
        textFieldOnChanged: original.textFieldOnChanged,
        emptyBuilder: original.emptyBuilder,
        itemBuilder: original.itemBuilder,
        errorBuilder: original.errorBuilder,
        loadingBuilder: original.loadingBuilder,
        showSelectedItems: original.showSelectedItems,
        disabledItemFn: original.disabledItemFn,
        isFilterOnline: original.isFilterOnline,
        containerBuilder: original.containerBuilder,
        constraints: original.constraints,
        interceptCallBacks: original.interceptCallBacks,
        onItemAdded: original.onItemAdded,
        onItemRemoved: original.onItemRemoved,
        selectionWidget: original.selectionWidget,
        validationWidgetBuilder: original.validationWidgetBuilder,
        textDirection: original.textDirection,
      );
    } else {
      return PopupPropsMultiSelection.modalBottomSheet(
        title: original.title,
        fit: original.fit,
        showSearchBox: widget.searchProps.showTextField ?? original.showSearchBox,
        modalBottomSheetProps: modalBottomSheetProps,
        searchFieldProps: searchFieldProps,
        scrollbarProps: original.scrollbarProps,
        listViewProps: listViewProps,
        favoriteItemProps: original.favoriteItemProps,
        searchDelay: original.searchDelay,
        onDismissed: original.onDismissed,
        emptyBuilder: original.emptyBuilder,
        textFieldOnChanged: original.textFieldOnChanged,
        itemBuilder: original.itemBuilder,
        errorBuilder: original.errorBuilder,
        loadingBuilder: original.loadingBuilder,
        showSelectedItems: original.showSelectedItems,
        disabledItemFn: original.disabledItemFn,
        isFilterOnline: original.isFilterOnline,
        containerBuilder: original.containerBuilder,
        constraints: original.constraints,
        interceptCallBacks: original.interceptCallBacks,
        onItemAdded: original.onItemAdded,
        onItemRemoved: original.onItemRemoved,
        selectionWidget: original.selectionWidget,
        validationWidgetBuilder: original.validationWidgetBuilder,
        textDirection: original.textDirection,
      );
    }
  }

  void _handleFocus(bool isFocused) {
    if (isFocused && !_isFocused.value) {
      FocusScope.of(context).unfocus();
      _isFocused.value = true;
    } else if (!isFocused && _isFocused.value) {
      _isFocused.value = false;
    }
  }

  void _handleOnChangeSelectedItems(List<T> selectedItems) {
    _selectedItemsNotifier.value = List.from(selectedItems);

    if (widget.onChanged != null) {
      widget.onChanged!(selectedItems);
    }

    _handleFocus(false);
  }

  List<T> parseNewValue(String newValue) {
    List<String> parts = newValue.split(',');
    List<T> newItems = parts.map((part) => parsePart(part)).toList();
    return newItems;
  }

  T parsePart(String part) {
    return part as T;
  }

  bool _isEqual(T i1, T i2) {
    if (widget.filterAndCompareProps.compareFn != null) {
      return widget.filterAndCompareProps.compareFn!(i1, i2);
    } else {
      return i1 == i2;
    }
  }

  Future<void> _selectSearchMode() async {
    if (widget.onBeforePopupOpeningMultiSelection != null) {
      if (await widget.onBeforePopupOpeningMultiSelection!(getSelectedItems) == false) return;
    }

    _handleFocus(true);
    if (widget.popupProps.mode == Mode.menu) {
      await _openMenu();
    } else if (widget.popupProps.mode == Mode.modelBottomSheet) {
      await _openModalBottomSheet();
    } else {
      await _openSelectDialog();
    }
    widget.popupProps.onDismissed?.call();
    _handleFocus(false);
  }

  void changeSelectedItem(T? selectedItem) => _handleOnChangeSelectedItems(_itemToList(selectedItem));

  void changeSelectedItems(List<T> selectedItems) => _handleOnChangeSelectedItems(selectedItems);

  void removeItem(T itemToRemove) => _handleOnChangeSelectedItems(
    getSelectedItems..removeWhere((i) => _isEqual(itemToRemove, i)),
  );

  void clearAllSelected() => _handleOnChangeSelectedItems([]);

  T? get getSelectedItem => getSelectedItems.isEmpty ? null : getSelectedItems.first;

  List<T> get getSelectedItems => _selectedItemsNotifier.value;

  bool get isFocused => _isFocused.value;

  void popupDeselectItems(List<T> itemsToDeselect) {
    _popupStateKey.currentState?.deselectItems(itemsToDeselect);
  }

  void popupDeselectAllItems() {
    _popupStateKey.currentState?.deselectAllItems();
  }

  void popupSelectAllItems() {
    _popupStateKey.currentState?.selectAllItems();
  }

  void popupSelectItems(List<T> itemsToSelect) {
    _popupStateKey.currentState?.selectItems(itemsToSelect);
  }

  void popupOnValidate() {
    _popupStateKey.currentState?.onValidate();
  }

  void popupValidate(List<T> itemsToValidate) {
    closeMultiSelectDropDown();
    changeSelectedItems(itemsToValidate);
  }

  void openMultiSelectDropDown() => _selectSearchMode();

  SelectionWidgetState<T>? get getPopupState => _popupStateKey.currentState;

  void closeMultiSelectDropDown() => _popupStateKey.currentState?.closePopup();

  bool get popupIsAllItemSelected => _popupStateKey.currentState?.isAllItemSelected ?? false;

  List<T> get popupGetSelectedItems => _popupStateKey.currentState?.getSelectedItem ?? [];

  void updatePopupState() => _popupStateKey.currentState?.setState(() {});
}
