import 'dart:io';
import 'dart:typed_data';

import 'package:audiobook/util/util.dart';
import 'package:http/http.dart';

class NetworkOperations {
  Future<Uint8List> getFileFromNetwork(String url, {OnError onError}) async {
    final bytes = await _loadFromUrl(url,
        onError: (Exception exception) => print('getFileFromNetwork => exception $exception'));

    return bytes;
  }

  /// Load a file from `url`
  Future<Uint8List> _loadFromUrl(String url, {OnError onError}) async {
    Uint8List bytes = Uint8List.fromList(new List(0));
    try {
      if (url != null) {
        bytes = await readBytes(Uri.parse(url));
      }
    } catch(e) {
      onError(e);
    }
    return bytes;
  }

  // Check internet connection,
  // Note that on Android, connection does not guarantee connection to Internet.
  // For instance, the phone may have wifi access but it might be a VPN or a hotel WiFi with no internet access.
  // and I didn't find a way to check it past checking if data/wifi is connected
  isConnectedToInternet() async {
    try {
      final result = await InternetAddress.lookup("www.google.com");
      if (result != null || result.isNotEmpty) return true;
    } on SocketException catch(_) {
      print("Not connected to the internet.");
    } on Exception catch (e) {
      print(e);
    }
    return false;
  }

  /// NetworkOperations instantiation
  static NetworkOperations _instance = NetworkOperations._internal();
  factory NetworkOperations() => _instance;
  NetworkOperations._internal();
}
