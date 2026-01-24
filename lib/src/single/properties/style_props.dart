import 'package:flutter/material.dart';

class StyleProps {
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
  final double? elevation;
  final Color? shadowColor;
  final ShapeBorder? shape;
  final ScrollPhysics? scrollPhysics;
  final EdgeInsetsGeometry? listViewPadding;

  const StyleProps({
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
    this.elevation,
    this.shadowColor,
    this.shape,
    this.listViewPadding,
    this.scrollPhysics,
  });
}
