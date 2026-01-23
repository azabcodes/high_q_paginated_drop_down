import 'package:flutter/material.dart';

class PaginatedStyleProps {
  final double? width;
  final EdgeInsetsGeometry? padding;
  final Widget Function(Widget child)? backgroundDecoration;
  final Decoration? menuDecoration;
  final double? dropDownMaxHeight;
  final bool isDialogExpanded;
  final double? paddingValueWhileIsDialogExpanded;
  final double? spaceBetweenDropDownAndItemsDialog;
  final Color? barrierColor;
  final bool? barrierDismissible;

  const PaginatedStyleProps({
    this.width,
    this.padding,
    this.backgroundDecoration,
    this.menuDecoration,
    this.dropDownMaxHeight,
    this.isDialogExpanded = true,
    this.paddingValueWhileIsDialogExpanded,
    this.spaceBetweenDropDownAndItemsDialog,
    this.barrierColor,
    this.barrierDismissible,
  });
}
