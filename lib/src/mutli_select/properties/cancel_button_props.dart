import 'package:flutter/material.dart';

class CancelButtonProps {
  final ButtonStyle? cancelButtonStyle;
  final TextStyle? cancelTextTextStyle;
  final EdgeInsetsGeometry? cancelButtonPadding;
  final String? cancelText;
  final Function()? onTap;

  /// if true, the button will be visible
  /// default is true
  final bool isVisible;

  const CancelButtonProps({
    this.cancelButtonStyle,
    this.cancelTextTextStyle,
    this.cancelText = 'Cancel',
    this.onTap,
    this.cancelButtonPadding = const EdgeInsets.symmetric(horizontal: 8),
    this.isVisible = true,
    this.builder,
  });

  /// A builder to customize the cancel button.
  /// [onPressed] must be called to cancel the selection.
  final Widget Function(VoidCallback onPressed)? builder;
}
