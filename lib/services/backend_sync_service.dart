import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'package:audiobook/util/util.dart';
import 'package:audiobook/model/version.dart';
import 'package:audiobook/util/constants.dart';
import 'package:audiobook/repository/media_player_repository.dart';
import 'package:uuid/uuid.dart';

/// BE update logic required a push notification or some sort of similarly working system. I can't afford that for now.
/// So, I created a way to check the version on the BE and update this client based on that number. It is not the best way,
/// but it is a good way to dodge through configuring notifications systems like RabbitMQ.
class BackendSyncService {
  MediaPlayerRepository repo = new MediaPlayerRepository();

  // === Methods for updating internal database ===

  /// Compare locally saved version number against what's on BE
  /// return next-version otherwise 0(whenever there is a problem)
  Future<int> isUpdateRequired() async {
    try {
      Version version = await repo.getLastVersionData();
      String url = Constants.VERSION_LATEST_EP + "?currentVersion=" +
          version.version.toString();
      Response response = await this.getCurrentVersionFromBE(url,
          onError: (Exception exception) =>
              print('getVersionData => exception $exception'));

      if (response != null &&
          response.body != null &&
          response.statusCode == 200) {
        Map<String, dynamic> v = jsonDecode(response.body);
        int nextVersion = v["nextVersion"];
        return nextVersion != null ? (nextVersion > version.version ? nextVersion : 0) : 0;
      }
    } catch(e) {
      print(e);
    }
  }

  // === Utility methods for External operations ===

  // getVersion data so as to check if there is a new updated data
  Future<Response> getCurrentVersionFromBE(String url, {Map<String, dynamic> headers, onError: OnError}) async {
    return await _callApi(url, headers: headers, onError: onError);
  }

  /// Get the next version from BE.
  /// Note: the BE might be very ahead of the client. e.g. client having v=1 and BE having v=100,
  /// this will be synced one at a time for each version, i.e. no bulk updates
  Future<Response> getNextLatestVersionData(int nextVersion, {Map<String, dynamic> headers, onError: OnError}) async {
    return await _callApi(Constants.VERSION_EP + "/" + nextVersion.toString(), headers: headers, onError: onError);
  }

  // get new post by id
  Future<Response> getPostById(String id, {Map<String, dynamic> headers, onError: OnError}) async {
    return await _callApi(Constants.POST_EP + "/" + id, headers: headers, onError: onError);
  }

  // get new category by id
  Future<Response> getCategoryById(String id, {Map<String, dynamic> headers, onError: OnError}) async {
    return await _callApi(Constants.CATEGORY_EP + "/" + id, headers: headers, onError: onError);
  }

  //call api
  Future<Response> _callApi(String url, {Map<String, dynamic> headers, OnError onError}) async {
    print("caling api on: " + url);
    Future<Response> response = Future.value(new Response("", HttpStatus.notFound));
    try {
      // TODO should I check request and response UUID equality here?
      Map<String, String> headersAll = Map.from({"transaction-id": generateRequestUUID()});
      headersAll.addAll(headers ?? {}); //headers or {}
      response = get(url, headers: headersAll);
    } catch (e) {
      print(e);
      onError(e);
    }
    return await response;
  }

  String generateRequestUUID() {
    return new Uuid().v1();
  }

  /// BackendSyncService instantiation
  BackendSyncService._internal();
  static BackendSyncService _instance;
  factory BackendSyncService() => _instance ??= BackendSyncService._internal();
}
