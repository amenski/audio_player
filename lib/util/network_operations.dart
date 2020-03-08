import 'dart:io';
import 'dart:typed_data';

import 'package:audiobook/util/util.dart';
import 'package:http/http.dart';

class NetworkOperations {
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
      if(url != null) {
        bytes = await readBytes(url);
      }
    } on Exception {
      rethrow;
    }
    return bytes;
  }

  // Check connection to internet, 
  // Note that on Android, connection does not guarantee connection to Internet. 
  // For instance, the app might have wifi access but it might be a VPN or a hotel WiFi with no access.
  // and didn't find a way to check it past checking if data/wifi is connected
  isConnectedToInternet() async {
    try {
      final result = await InternetAddress.lookup("www.google.com");
      if(result != null || result.isNotEmpty)
        return true;
    } catch(e) {
      print(e);
    }
    return false;
  }

   /// NetworkOperations instantiation
  static NetworkOperations _instance = NetworkOperations._internal();
  factory NetworkOperations() => _instance;
  NetworkOperations._internal();
}