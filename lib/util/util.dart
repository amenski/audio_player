import 'package:flutter/material.dart';

typedef OnError = void Function(Exception exception);

typedef OnCardTap = void Function(BuildContext context, int id);

class Util {
 
  generateMediaFileName(var input) {
    StringBuffer stringBuffer = new StringBuffer();
    String source = _getInputString(input);
    
    for(int i=0; i < source.length; i++) {
      if(source[i] != null && source[i] != ' ')
        stringBuffer.write(source[i]);
    }

    return stringBuffer.toString();
  }

  _getInputString(List<String> input) {
    for(int i = 0; i < input.length; i ++) {
     if(input[i] != null && input[i].trim().isNotEmpty) {
        return input[i];
     }
    }

    return null;
  }

  /// Util instantiation
  static Util _instance = Util._internal();
  factory Util() => _instance;
  Util._internal();
}
