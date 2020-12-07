import 'dart:io';
import 'package:audiobook/util/util.dart';
import 'package:http/http.dart';

class BackendSyncService {
  // getVersion data so as to check if there is a new updated data
  Future<Response> getVersionData(String url) async {
    final Response response = await _callApi(url,
        onError: (Exception exception) =>
            print('getVersionData => exception $exception'));

    return response;
  }

  //call api
  Future<Response> _callApi(String url, {Map<String, dynamic> header, OnError onError}) {
    Future<Response> response =
        Future.value(new Response("", HttpStatus.notFound));
    try {
      response = get(url);
    } catch (e) {
      onError(e);
    }
    return response;
  }

  /// BackendSyncService instantiation
  BackendSyncService._internal();
  static BackendSyncService _instance = BackendSyncService._internal();
  factory BackendSyncService() => _instance;
}
