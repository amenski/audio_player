import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';

typedef OnError = void Function(Exception exception);

typedef OnCardTap = void Function(BuildContext context, int id);

class Util {
  /// Load a file from `url`
  Future<Uint8List> loadFromUrl(String url, {OnError onError}) async {
    Uint8List bytes;
    try {
      bytes = await readBytes(url);
    } on Exception {
      rethrow;
    }
    return bytes;
  }

  /// Download file to local storage.
  Future<File> downloadFromUrl(String url) async {
    final bytes = await loadFromUrl(url,
        onError: (Exception exception) =>
            print('_loadFile => exception $exception'));

    final dir = await getApplicationDocumentsDirectory();
    final file = new File('${dir.path}/audio.mp3');

    return file.writeAsBytes(bytes);
  }

  /// Util instantiation
  static Util _instance = Util._internal();
  factory Util() => _instance;
  Util._internal();
}
