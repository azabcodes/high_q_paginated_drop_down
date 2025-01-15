import 'dart:developer';

import 'package:flutter/foundation.dart';

import 'colored_print.dart';

class PrintManager {
  static void printFullText(String text) {
    final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
    pattern.allMatches(text).forEach((match) => log(match.group(0).toString()));
  }

  static void printItem({
    required dynamic item,
    bool printFirst = true,
  }) {
    if (kDebugMode) {
      if (printFirst == true) {
        log(AppStringsManager.printEqual);
      }
      log(item.toString());
      log(AppStringsManager.printEqual);
    }
  }

  static void printColoredText({
    required dynamic item,
    required ConsoleColor color,
    bool printFirst = true,
  }) {
    final colorCode = ColoredPrint.colorCodes[color];
    if (colorCode != null) {
      if (printFirst == true) {
        log(AppStringsManager.printEqual);
      }
      log('$colorCode$item${ColoredPrint.colorCodes[ConsoleColor.reset]}');
      log(AppStringsManager.printEqual);
    } else {
      log(item);
      log(AppStringsManager.printEqual);
    }
  }
}

class AppStringsManager {
  static const printEqual = "══════════════════════════════════════════════>>";
  static const printEqual2 =
      "──────────────────────────────────────────────────────────────────────";
}
