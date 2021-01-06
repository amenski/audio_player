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

  // === Utility methods for External operations ===

  /// Get the next version from BE.
  /// Note: the BE might be very ahead of the client. e.g. client having v=1 and BE having v=100,
  /// this will be synced one at a time for each version, i.e. no bulk updates
  Future<Response> getNextVersionData({Map<String, dynamic> headers, OnError onError}) async {
    Version version = await repo.getLastVersionData();
    String getNextVersionurl = Constants.VERSION_EP + "?currentVersion=" + version.version.toString();
    return await _callApi(getNextVersionurl, headers: headers, onError: onError);
  }

  // get new post by id
  Future<Response> getPostById(String id, {Map<String, dynamic> headers,  OnError onError}) async {
    return await _callApi(Constants.POST_EP + "/" + id, headers: headers, onError: onError);
  }

  // get new category by id
  Future<Response> getCategoryById(String id, {Map<String, dynamic> headers,  OnError onError}) async {
    return await _callApi(Constants.CATEGORY_EP + "/" + id, headers: headers, onError: onError);
  }

  //call api
  Future<Response> _callApi(String url, {Map<String, dynamic> headers, OnError onError}) async {
    print("calling api on: " + url);
    // Future<Response> response = Future.value(new Response("", HttpStatus.notFound));
    try {
      // TODO should I check request and response UUID equality here?
      String tx = generateRequestUUID();
      Map<String, String> headersAll = Map.from({
        "transaction-id": tx,
        "Content-Type": "application/json"
      });
      headersAll.addAll(headers ?? {}); //headers or {}
      return await get(url, headers: headersAll);
    } catch (e) {
      onError(e);
      throw e;
    }
  }

  String generateRequestUUID() {
    return new Uuid().v1();
  }

  /// BackendSyncService instantiation
  BackendSyncService._internal();
  static BackendSyncService _instance;
  factory BackendSyncService() => _instance ??= BackendSyncService._internal();
}
