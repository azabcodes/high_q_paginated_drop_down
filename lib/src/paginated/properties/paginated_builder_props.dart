import 'package:flutter/material.dart';

class PaginatedBuilderProps<T> {
  final Widget Function(BuildContext context, int index)? separatorBuilder;
  final Widget Function(BuildContext context, T? item)? selectedItemBuilder;
  final Widget Function(String searchEntry)? emptyBuilder;
  final Widget loadingWidget;
  final Widget? noRecordText;
  final Widget? hintText;

  const PaginatedBuilderProps({
    this.separatorBuilder,
    this.selectedItemBuilder,
    this.emptyBuilder,
    this.loadingWidget = const CircularProgressIndicator.adaptive(),
    this.noRecordText,
    this.hintText,
  });
}
