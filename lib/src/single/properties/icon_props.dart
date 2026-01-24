import 'package:flutter/material.dart';

class IconProps {
  final bool hasTrailingClearIcon;
  final Widget? trailingIcon;
  final Widget? trailingClearIcon;
  final Widget? leadingIcon;

  const IconProps({
    this.hasTrailingClearIcon = true,
    this.trailingIcon,
    this.trailingClearIcon,
    this.leadingIcon,
  });
}
