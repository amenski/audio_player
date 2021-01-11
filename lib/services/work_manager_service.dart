import 'dart:convert';

import 'package:http/http.dart';
import 'package:audiobook/model/post.dart';
import 'package:audiobook/model/version.dart';
import 'package:workmanager/workmanager.dart';
import 'package:audiobook/util/constants.dart';
import 'package:audiobook/model/category.dart';
import 'package:audiobook/services/backend_sync_service.dart';
import 'package:audiobook/repository/media_player_repository.dart';

/// A top level function(a func outside of a class), used as an entry-point for flutter WorkManager
void callbackBackgroundWorkDispatcher() {
  Workmanager.executeTask((taskName, inputData) async {
    switch (taskName) {
      case Constants.SyncEveryDay:
        try {
          BackendSyncService beService = BackendSyncService();
          MediaPlayerRepository mediaPlayerRepository = new MediaPlayerRepository();
          Response response = await beService.getNextVersionData(onError: (e) => print("callbackBackgroundWorkDispatcher(): Unable to fetch data: $e"));
          if (response != null) {
            Map<String, dynamic> responseData = json.decode(response.body);
            if (responseData["resultCode"] == 200) {
              Version next = Version.fromJson(responseData["returnValue"]);
              switch (next.type) {
                case "P":
                  Response postResponse = await beService.getPostById(
                      next.objectId,
                      onError: (Exception e) => print("callbackBackgroundWorkDispatcher(): Unable to fetch data: $e"));

                  final parsedPost = json.decode(postResponse.body);
                  // get id of category
                  Category category = await mediaPlayerRepository.findCategoryByExternalId(parsedPost["returnValue"]["categoryId"]);
                  Post post = Post.fromJson(parsedPost["returnValue"]);
                  post.categoryId = category.id; // set parent id
                  int newId =
                      await mediaPlayerRepository.saveNewPost(post.toMap());
                  if (newId != null) {
                    await mediaPlayerRepository.saveLastVersionData(next.version);
                  }
                  break;
                case "C":
                  Response catResponse = await beService.getCategoryById(
                      next.objectId,
                      onError: (Exception e) => print("callbackBackgroundWorkDispatcher(): Unable to fetch data: $e"));
                  //removes unnecessary fields like createdAt
                  final parsedResponse = json.decode(catResponse.body);
                  Category cat =
                      Category.fromJson(parsedResponse["returnValue"]);
                  int newId = await mediaPlayerRepository.saveNewCategory(cat.toMap());
                  if (newId != null) {
                    await mediaPlayerRepository.saveLastVersionData(next.version);
                  }
                  break;
                default:
                  print("No case for : ${next.type}");
                  break;
              }
            }
          }
        } catch (e) {
          print(e);
        }
        break;
      case Workmanager.iOSBackgroundTask:
        print("Not yet implemented.");
        break;
      default:
        return false;
    }
    return true;
  });
}

/// Background task executor service
/// Because of some limitations
///   - No real push notification(we have to call BE manual way),
///   - Any particular call will only download 1 item(post/category)...
/// the job should run at least once a day to overcome the second case.
class WorkManagerService {
  void initializeWorker() {
    Workmanager.initialize(callbackBackgroundWorkDispatcher, isInDebugMode: false);
  }

  void registerPeriodicTask() {
    Workmanager.registerPeriodicTask(
        Constants.SyncEveryWeek,
        Constants.SyncEveryWeek,
        constraints: Constraints(networkType: NetworkType.connected, requiresBatteryNotLow: true),
        initialDelay: Duration(seconds: 10),
        frequency: Duration(minutes: 15));
  }

  void registerOneTimeTask() {
    Workmanager.registerOneOffTask(
        Constants.SyncEveryDay,
        Constants.SyncEveryDay,
        constraints: Constraints(networkType: NetworkType.connected, requiresBatteryNotLow: true));
  }
}
