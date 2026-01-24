import 'package:flutter/material.dart';

class ConfirmButtonProps {
  final ButtonStyle? confirmButtonStyle;
  final TextStyle? confirmTextTextStyle;
  final EdgeInsetsGeometry? confirmButtonPadding;
  final String? confirmText;
  final Function()? afterPopTheDialog;

  const ConfirmButtonProps({
    this.confirmButtonStyle,
    this.confirmTextTextStyle,
    this.confirmText,
    this.afterPopTheDialog,
    this.confirmButtonPadding = const EdgeInsets.symmetric(horizontal: 8),
    this.builder,
  });

  /// A builder to customize the confirm button.
  /// [onPressed] must be called to validate the selection.
  final Widget Function(VoidCallback onPressed)? builder;
}
