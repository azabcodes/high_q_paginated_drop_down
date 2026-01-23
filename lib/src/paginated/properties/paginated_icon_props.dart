import 'package:flutter/material.dart';

class PaginatedIconProps {
  final bool hasTrailingClearIcon;
  final Widget? trailingIcon;
  final Widget? trailingClearIcon;
  final Widget? leadingIcon;

  const PaginatedIconProps({
    this.hasTrailingClearIcon = true,
    this.trailingIcon,
    this.trailingClearIcon,
    this.leadingIcon,
  });
}
