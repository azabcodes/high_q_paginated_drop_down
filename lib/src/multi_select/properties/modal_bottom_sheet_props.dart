import 'package:flutter/material.dart';

class ModalBottomSheetProps {
  final ShapeBorder? shape;
  final bool useRootNavigator;
  final BoxConstraints? constraints;
  final double? elevation;
  final Color? barrierColor;
  final Color? backgroundColor;
  final bool barrierDismissible;
  final Clip clipBehavior;
  final AnimationController? animation;
  final bool enableDrag;
  final Offset? anchorPoint;
  final bool isScrollControlled;
  final EdgeInsets padding;
  final bool useSafeArea;

  const ModalBottomSheetProps({
    this.anchorPoint,
    this.elevation,
    this.shape,
    this.barrierColor,
    this.backgroundColor,
    this.barrierDismissible = true,
    this.animation,
    this.enableDrag = true,
    this.clipBehavior = Clip.none,
    this.useRootNavigator = false,
    this.constraints,
    this.isScrollControlled = true,
    this.padding = EdgeInsets.zero,
    this.useSafeArea = true,
  });

  ModalBottomSheetProps copyWith({
    Offset? anchorPoint,
    double? elevation,
    ShapeBorder? shape,
    Color? barrierColor,
    Color? backgroundColor,
    bool? barrierDismissible,
    AnimationController? animation,
    bool? enableDrag,
    Clip? clipBehavior,
    bool? useRootNavigator,
    BoxConstraints? constraints,
    bool? isScrollControlled,
    EdgeInsets? padding,
    bool? useSafeArea,
  }) {
    return ModalBottomSheetProps(
      anchorPoint: anchorPoint ?? this.anchorPoint,
      elevation: elevation ?? this.elevation,
      shape: shape ?? this.shape,
      barrierColor: barrierColor ?? this.barrierColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      barrierDismissible: barrierDismissible ?? this.barrierDismissible,
      animation: animation ?? this.animation,
      enableDrag: enableDrag ?? this.enableDrag,
      clipBehavior: clipBehavior ?? this.clipBehavior,
      useRootNavigator: useRootNavigator ?? this.useRootNavigator,
      constraints: constraints ?? this.constraints,
      isScrollControlled: isScrollControlled ?? this.isScrollControlled,
      padding: padding ?? this.padding,
      useSafeArea: useSafeArea ?? this.useSafeArea,
    );
  }
}
