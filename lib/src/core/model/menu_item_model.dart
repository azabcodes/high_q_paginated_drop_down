import 'package:flutter/material.dart';

class MenuItemModel<T> {
  final String label;

  final T? value;

  final VoidCallback? onTap;

  final Widget? child;

  const MenuItemModel({
    required this.label,
    this.child,
    this.value,
    this.onTap,
  });
}
