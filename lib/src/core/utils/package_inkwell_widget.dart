import 'package:flutter/material.dart';

class PackageInkwellWidget extends StatelessWidget {
  final bool disableTabEffect;
  final EdgeInsets? padding;
  final VoidCallback? onTap;
  final double? borderRadius;
  final Widget child;

  const PackageInkwellWidget({
    required this.onTap,
    required this.child,
    super.key,
    this.padding,
    this.borderRadius,
    this.disableTabEffect = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      focusColor: disableTabEffect ? Colors.white : null,
      splashColor: disableTabEffect ? Colors.white : null,
      highlightColor: disableTabEffect ? Colors.white : null,
      onTap: onTap,
      borderRadius:  BorderRadius.all(Radius.circular(borderRadius ??8)),
      child: Padding(
        padding: padding ?? const EdgeInsets.all(8),
        child: child,
      ),
    );
  }
}
