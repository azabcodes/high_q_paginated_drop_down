import 'package:flutter/material.dart';

class DialogProps {
  final List<Widget>? actions;
  final MainAxisAlignment? actionsAlignment;
  final OverflowBarAlignment? actionsOverflowAlignment;
  final double? actionsOverflowButtonSpacing;
  final VerticalDirection? actionsOverflowDirection;
  final EdgeInsetsGeometry actionsPadding;
  final EdgeInsets insetPadding;
  final EdgeInsetsGeometry? buttonPadding;
  final EdgeInsetsGeometry contentPadding;
  final Offset? anchorPoint;
  final RouteTransitionsBuilder? transitionBuilder;
  final ShapeBorder? shape;
  final bool useRootNavigator;
  final double? elevation;
  final String? semanticLabel;
  final Color? barrierColor;
  final String barrierLabel;
  final Color? backgroundColor;
  final bool barrierDismissible;
  final Duration transitionDuration;
  final Clip clipBehavior;
  final AnimationController? animation;
  final AlignmentGeometry? alignment;

  const DialogProps({
    this.alignment,
    this.elevation,
    this.semanticLabel,
    this.shape,
    this.barrierColor,
    this.barrierLabel = '',
    this.backgroundColor,
    this.barrierDismissible = true,
    this.transitionDuration = kThemeChangeDuration,
    this.animation,
    this.actions,
    this.actionsAlignment,
    this.actionsOverflowAlignment,
    this.actionsOverflowButtonSpacing,
    this.actionsOverflowDirection,
    this.clipBehavior = Clip.none,
    this.useRootNavigator = false,
    this.actionsPadding = EdgeInsets.zero,
    this.insetPadding = const EdgeInsets.symmetric(
      horizontal: 40.0,
      vertical: 24.0,
    ),
    this.buttonPadding,
    this.contentPadding = EdgeInsets.zero,
    this.anchorPoint,
    this.transitionBuilder,
  });

  DialogProps copyWith({
    AlignmentGeometry? alignment,
    double? elevation,
    String? semanticLabel,
    ShapeBorder? shape,
    Color? barrierColor,
    String? barrierLabel,
    Color? backgroundColor,
    bool? barrierDismissible,
    Duration? transitionDuration,
    AnimationController? animation,
    List<Widget>? actions,
    MainAxisAlignment? actionsAlignment,
    OverflowBarAlignment? actionsOverflowAlignment,
    double? actionsOverflowButtonSpacing,
    VerticalDirection? actionsOverflowDirection,
    Clip? clipBehavior,
    bool? useRootNavigator,
    EdgeInsetsGeometry? actionsPadding,
    EdgeInsets? insetPadding,
    EdgeInsetsGeometry? buttonPadding,
    EdgeInsetsGeometry? contentPadding,
    Offset? anchorPoint,
    RouteTransitionsBuilder? transitionBuilder,
  }) {
    return DialogProps(
      alignment: alignment ?? this.alignment,
      elevation: elevation ?? this.elevation,
      semanticLabel: semanticLabel ?? this.semanticLabel,
      shape: shape ?? this.shape,
      barrierColor: barrierColor ?? this.barrierColor,
      barrierLabel: barrierLabel ?? this.barrierLabel,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      barrierDismissible: barrierDismissible ?? this.barrierDismissible,
      transitionDuration: transitionDuration ?? this.transitionDuration,
      animation: animation ?? this.animation,
      actions: actions ?? this.actions,
      actionsAlignment: actionsAlignment ?? this.actionsAlignment,
      actionsOverflowAlignment: actionsOverflowAlignment ?? this.actionsOverflowAlignment,
      actionsOverflowButtonSpacing: actionsOverflowButtonSpacing ?? this.actionsOverflowButtonSpacing,
      actionsOverflowDirection: actionsOverflowDirection ?? this.actionsOverflowDirection,
      clipBehavior: clipBehavior ?? this.clipBehavior,
      useRootNavigator: useRootNavigator ?? this.useRootNavigator,
      actionsPadding: actionsPadding ?? this.actionsPadding,
      insetPadding: insetPadding ?? this.insetPadding,
      buttonPadding: buttonPadding ?? this.buttonPadding,
      contentPadding: contentPadding ?? this.contentPadding,
      anchorPoint: anchorPoint ?? this.anchorPoint,
      transitionBuilder: transitionBuilder ?? this.transitionBuilder,
    );
  }
}
