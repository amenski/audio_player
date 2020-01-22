import 'package:flutter/material.dart';

typedef OnError = void Function(Exception exception);

typedef OnCardTap = void Function(BuildContext context, int id);

class Util {
 
  // remove space char as much as possible
  generateMediaFIleName(var input) {
    String source = input[0] ?? input[1];
    return replace(' ', source, '');
  }

  String replace(final String text, final String searchText, final String replacement) {
    String output;
      for (int i = 0; i < searchText.length; i++) {
        int start = searchText.indexOf(text);
        output = searchText.replaceRange(start, text.length, replacement);
      }

      return output;
  }
  /// Util instantiation
  static Util _instance = Util._internal();
  factory Util() => _instance;
  Util._internal();
}
