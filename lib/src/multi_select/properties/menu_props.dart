import 'package:flutter/material.dart';
import '../../../high_q_paginated_drop_down.dart';

class MenuProps {
  final ShapeBorder? shape;
  final double? elevation;
  final Color? barrierColor;
  final Color? backgroundColor;
  final bool barrierDismissible;
  final Clip clipBehavior;
  final AnimationController? animation;
  final BorderRadiusGeometry? borderRadius;
  final Duration animationDuration;
  final Color? shadowColor;
  final bool borderOnForeground;
  final Curve? barrierCurve;
  final String? barrierLabel;
  final PositionCallback? positionCallback;

  const MenuProps({
    this.barrierLabel,
    this.barrierCurve,
    this.elevation,
    this.shape,
    this.positionCallback,
    this.barrierColor,
    this.backgroundColor,
    this.barrierDismissible = true,
    this.animation,
    this.clipBehavior = Clip.none,
    this.animationDuration = const Duration(milliseconds: 300),
    this.borderOnForeground = false,
    this.borderRadius,
    this.shadowColor,
  });

  MenuProps copyWith({
    String? barrierLabel,
    Curve? barrierCurve,
    double? elevation,
    ShapeBorder? shape,
    PositionCallback? positionCallback,
    Color? barrierColor,
    Color? backgroundColor,
    bool? barrierDismissible,
    AnimationController? animation,
    Clip? clipBehavior,
    Duration? animationDuration,
    bool? borderOnForeground,
    BorderRadiusGeometry? borderRadius,
    Color? shadowColor,
  }) {
    return MenuProps(
      barrierLabel: barrierLabel ?? this.barrierLabel,
      barrierCurve: barrierCurve ?? this.barrierCurve,
      elevation: elevation ?? this.elevation,
      shape: shape ?? this.shape,
      positionCallback: positionCallback ?? this.positionCallback,
      barrierColor: barrierColor ?? this.barrierColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      barrierDismissible: barrierDismissible ?? this.barrierDismissible,
      animation: animation ?? this.animation,
      clipBehavior: clipBehavior ?? this.clipBehavior,
      animationDuration: animationDuration ?? this.animationDuration,
      borderOnForeground: borderOnForeground ?? this.borderOnForeground,
      borderRadius: borderRadius ?? this.borderRadius,
      shadowColor: shadowColor ?? this.shadowColor,
    );
  }
}
