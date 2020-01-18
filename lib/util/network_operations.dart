import 'dart:typed_data';

import 'package:flutter_audio_palyer/util/util.dart';
import 'package:http/http.dart';

class NetworkOperations {
  

  Future<Uint8List> getImageFromNetwork(String url, {  OnError onError}) async {
    final bytes = await _loadFromUrl(url,
        onError: (Exception exception) =>
            print('getImageFromNetwork => exception $exception'));

    return bytes;
  }
  
   Future<Uint8List> getFileFromNetwork(String url, { OnError onError}) async {
    final bytes = await _loadFromUrl(url,
        onError: (Exception exception) =>
            print('getFileFromNetwork => exception $exception'));

    return bytes;
  }

  /// Load a file from `url`
  Future<Uint8List> _loadFromUrl(String url, {OnError onError}) async {
    Uint8List bytes;
    try {
      bytes = await readBytes(url);
    } on Exception {
      rethrow;
    }
    return bytes;
  }

   /// NetworkOperations instantiation
  static NetworkOperations _instance = NetworkOperations._internal();
  factory NetworkOperations() => _instance;
  NetworkOperations._internal();
}