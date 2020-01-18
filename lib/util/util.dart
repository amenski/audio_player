import 'package:flutter/material.dart';

typedef OnError = void Function(Exception exception);

typedef OnCardTap = void Function(BuildContext context, int id);

class Util {
 

  /// Util instantiation
  static Util _instance = Util._internal();
  factory Util() => _instance;
  Util._internal();
}
