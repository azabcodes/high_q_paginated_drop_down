import 'package:flutter/material.dart';

class PaginatedSearchProps {
  final bool showTextField;

  final InputDecoration? textFieldDecoration;
  final Duration? searchDelayDuration;

  const PaginatedSearchProps({
    this.showTextField = true,

    this.textFieldDecoration,
    this.searchDelayDuration,
  });
}
