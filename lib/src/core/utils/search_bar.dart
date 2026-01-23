import 'package:async/async.dart';
import 'package:flutter/material.dart';

import 'package_inkwell_widget.dart';

class PackageSearchBar extends StatelessWidget {
  final Duration searchDelayDuration;
  final FocusNode? focusNode;
  final TextEditingController? controller;
  final TextStyle? style;
  final InputDecoration? textFieldDecoration;

  final void Function(String value)? onChangeComplete;

  const PackageSearchBar({
    super.key,
    this.onChangeComplete,
    this.searchDelayDuration = const Duration(milliseconds: 800),
    this.focusNode,
    this.controller,
    this.style,
    this.textFieldDecoration = const InputDecoration(isDense: true),
  });

  @override
  Widget build(BuildContext context) {
    final FocusNode myFocusNode = focusNode ?? FocusNode();

    return PackageInkwellWidget(
      padding: EdgeInsets.zero,
      disableTabEffect: true,
      onTap: myFocusNode.requestFocus,
      child: SearchTextFormField(
        onChangeComplete: onChangeComplete,
        searchDelayDuration: searchDelayDuration,
        focusNode: focusNode,
        controller: controller,
        style: style,
        textFieldDecoration: textFieldDecoration,
      ),
    );
  }
}

class SearchTextFormField extends StatelessWidget {
  final Duration searchDelayDuration;
  final FocusNode? focusNode;

  final TextEditingController? controller;
  final TextStyle? style;
  final void Function(String value)? onChangeComplete;

  final InputDecoration? textFieldDecoration;

  const SearchTextFormField({
    this.onChangeComplete,
    this.searchDelayDuration = const Duration(milliseconds: 800),

    this.focusNode,
    this.controller,
    this.style,
    this.textFieldDecoration = const InputDecoration(isDense: true),
  });

  @override
  Widget build(BuildContext context) {
    CancelableOperation<dynamic>? cancelableOperation;

    void startCancelableOperation() {
      cancelableOperation = CancelableOperation.fromFuture(
        Future.delayed(searchDelayDuration),
      );
    }

    return TextField(
      controller: controller,
      focusNode: focusNode,
      onChanged: (value) async {
        await cancelableOperation?.cancel();
        startCancelableOperation();
        await cancelableOperation?.value.whenComplete(() {
          onChangeComplete?.call(value);
        });
      },
      style: style,
      decoration:
          textFieldDecoration?.copyWith(
            hintText: textFieldDecoration?.hintText ?? 'Type to search ...',
          ) ??
          InputDecoration(
            border: InputBorder.none,
            enabledBorder: OutlineInputBorder(),
            focusedBorder: InputBorder.none,
            contentPadding: EdgeInsets.zero,
          ),
    );
  }
}
