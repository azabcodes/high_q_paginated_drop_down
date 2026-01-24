import 'package:flutter/material.dart';

class SearchProps {
  final bool? showTextField;
  final InputDecoration? textFieldDecoration;
  final Duration? searchDelayDuration;
  final TextStyle? style;
  final Color? cursorColor;
  final TextAlign? textAlign;

  const SearchProps({
    this.showTextField,
    this.textFieldDecoration,
    this.searchDelayDuration,
    this.style,
    this.cursorColor,
    this.textAlign,
  });
}
