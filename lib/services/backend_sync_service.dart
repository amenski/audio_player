import 'dart:io';
import 'package:http/http.dart';
import 'package:audiobook/util/util.dart';
import 'package:audiobook/model/version.dart';
import 'package:audiobook/util/constants.dart';
import 'package:audiobook/repository/media_player_repository.dart';

/// BE update logic required a push notification or some sort of similarly working system. I can't afford that for now.
/// So, I created a way to check the version on the BE and update this client based on that number. It is not the best way,
/// but it is a good way to dodge through configuring notifications systems like RabbitMQ.
class BackendSyncService {
  MediaPlayerRepository repo = new MediaPlayerRepository();

  // === Methods for updating internal database ===

  /// Compare locally saved version number against what's on BE
  /// return next-version or 0
  Future<int> isUpdateRequired() async {
    Response response = await this.getCurrentVersionFromBE(Constants.VERSION_LATEST_EP,
        onError: (Exception exception) => print('getVersionData => exception $exception'));

    Version version = await repo.getLastVersionData();
    if (response != null &&
        response.body != null &&
        int.parse(response.body) > version.version)
      return version.version + 1; //TODO what if there is a gap?
    return 0;
  }

  // === Utility methods for External operations ===

  // getVersion data so as to check if there is a new updated data
  Future<Response> getCurrentVersionFromBE(String url, {onError: OnError}) async {
    return await _callApi(url, onError: onError);
  }

  /// Get the next version from BE.
  /// Note: the BE might be very ahead of the client. e.g. client having v=1 and BE having v=100,
  /// this will be synced one at a time for each version, i.e. no bulk updates
  Future<Response> getNextLatestVersionData(int nextVersion, {onError: OnError}) async {
    return await _callApi(Constants.VERSION_EP + "/" + nextVersion.toString(), onError: onError);
  }

  // get new post by id
  Future<Response> getPostById(String id, {onError: OnError}) async {
    return await _callApi(Constants.POST_EP + "/" + id, onError: onError);
  }

  // get new category by id
  Future<Response> getCategoryById(String id, {onError: OnError}) async {
    return await _callApi(Constants.CATEGORY_EP + "/" + id, onError: onError);
  }

  //call api
  Future<Response> _callApi(String url, {Map<String, dynamic> headers, OnError onError}) async {
    print("caling api on: " + url);
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
  static BackendSyncService _instance;
  factory BackendSyncService() => _instance ??= BackendSyncService._internal();
}
