import 'dart:convert';

import 'package:audiobook/model/category.dart';
import 'package:audiobook/model/post.dart';
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
  MediaPlayerRepository mediaPlayerRepository = new MediaPlayerRepository();

  // === Utility methods for External operations ===

  /// Get the next version from BE.
  /// Note: the BE might be very ahead of the client. e.g. client having v=1 and BE having v=100,
  /// this will be synced one at a time for each version, i.e. no bulk updates
  Future<Response> getNextVersionData({Map<String, dynamic> headers, OnError onError}) async {
    Version version = await mediaPlayerRepository.getLastVersionData();
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

  // Get initial data that a user needs to download after installing the app
  Future<void> getInitialKit() async {
    Response response = await _callApi(Constants.INITIAL_DATA_EP, onError: (Exception e) => {print("getInitialKit(): error calling external api: $e")});
    if(response != null) {
      Map<String, dynamic> responseData = json.decode(response.body);
      if (responseData["resultCode"] == 200) {
        dynamic kit = responseData["returnValue"]["list"];
        if(kit != null) {
          for (int i = 0; i < kit.length; i++) {
            Version next = Version.fromJson(kit[i]);
            await syncData(next);
          }
        }
      }
    }
  }

  //call api
  Future<Response> _callApi(String url, {Map<String, dynamic> headers, OnError onError}) async {
    //print("calling api on: " + url);
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

  /// Saves data coming from server
  /// used in workManagerService for periodic tasks and here(BackendSyncService) for initial data
  Future<void> syncData(Version next) async {
    try {
      switch (next.type) {
        case "P":
          Response postResponse = await getPostById(
              next.objectId,
              onError: (Exception e) => print("syncData(): Unable to fetch data: $e"));

          final parsedPost = json.decode(postResponse.body);
          // get id of category
          Category category = await mediaPlayerRepository.findCategoryByExternalId(parsedPost["returnValue"]["categoryId"]);
          Post post = Post.fromJson(parsedPost["returnValue"]);
          post.categoryId = category.id; // set parent id
          int newId = await mediaPlayerRepository.saveNewPost(post.toMap());
          if (newId != null) {
            await mediaPlayerRepository.saveLastVersionData(next.version);
          }
          break;
        case "C":
          Response catResponse = await getCategoryById(
              next.objectId,
              onError: (Exception e) => print("syncData(): Unable to fetch data: $e"));
          //removes unnecessary fields like createdAt
          final parsedResponse = json.decode(catResponse.body);
          Category cat = Category.fromJson(parsedResponse["returnValue"]);
          int newId = await mediaPlayerRepository.saveNewCategory(cat.toMap());
          if (newId != null) {
            await mediaPlayerRepository.saveLastVersionData(next.version);
          }
          break;
        default:
          print("No case for : ${next.type}");
          break;
      }
    } catch(e) {print(e);}
  }

  /// BackendSyncService instantiation
  BackendSyncService._internal();
  static BackendSyncService _instance;
  factory BackendSyncService() => _instance ??= BackendSyncService._internal();
}
