import 'dart:io';
import 'package:audiobook/model/version.dart';
import 'package:audiobook/repository/media_player_repository.dart';
import 'package:audiobook/util/constants.dart';
import 'package:audiobook/util/util.dart';
import 'package:http/http.dart';

/// BE update logic required a push notification or some sort of similarly working system. I can't afford that for now.
/// So, I created a way to check the version on the BE and update this client based on that number. It is not the best way,
/// but it is a good way to dodge through configuring notifications systems like RabbitMQ.
class BackendSyncService {
  MediaPlayerRepository repo = new MediaPlayerRepository();

  // === Methods for updating internal database ===

  /// Compare locally saved version number against what's on BE
  /// return true if they are different
  Future<bool> isUpdateRequired() async {
    Response response = await this.getCurrentVersionFromBE(Constants.LAST_VERSION_EP,
        onError: (Exception exception) => print('getVersionData => exception $exception'));

    Version version = await repo.getLastVersionData();
    return (response != null &&
        response.body != null &&
        int.parse(response.body) > version.version);
  }

  // === Utility methods External operations ===

  // getVersion data so as to check if there is a new updated data
  Future<Response> getCurrentVersionFromBE(String url, {onError: OnError}) async {
    return await _callApi(url, onError: onError);
  }

  //call api
  Future<Response> _callApi(String url, {Map<String, dynamic> header, OnError onError}) async {
    Future<Response> response = Future.value(new Response("", HttpStatus.notFound));
    try {
      response = get(url);
    } catch (e) {
      onError(e);
    }
    return await response;
  }

  /// BackendSyncService instantiation
  BackendSyncService._internal();
  static final BackendSyncService _instance = BackendSyncService._internal();
  factory BackendSyncService() => _instance;
}
