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
      case Constants.SyncEveryWeek:
        BackendSyncService beService = BackendSyncService();
        MediaPlayerRepository mediaPlayerRepository = new MediaPlayerRepository();
        int nextVersion = await beService.isUpdateRequired();
        if (nextVersion != 0) {
          Response response = await beService.getNextLatestVersionData(nextVersion, onError: (Exception e) => print("callbackBackgroundWorkDispatcher(): Unable to fetch data: $e"));
          Version next = Version.fromJson(response.body);
          if (next != null && next.type != null) {
            switch (next.type) {
              case "P":
                Response postResponse = await beService.getPostById(
                    next.objectId,
                    onError: (Exception e) => print("callbackBackgroundWorkDispatcher(): Unable to fetch data: $e"));
                Map<String, dynamic> map = jsonDecode(postResponse.body);
                // get id of category
                Category category = await mediaPlayerRepository.findCategoryByExternalId(map["categoryId"]);

                // remove unnecessary fields(before sending the map) and the data-type of categoryId on BE and client are different
                map.removeWhere((key, value) => key == "_id" || key == "categoryId" || key == "modifiedAt");
                Post post = Post.fromMap(map);
                post.categoryId = category.id;
                int newId = await mediaPlayerRepository.saveNewPost(post.toMap());
                if (newId != null) {
                  await mediaPlayerRepository.saveLastVersionData(next.version);
                }
                break;
              case "C":
                Response catResponse = await beService.getCategoryById(
                    next.objectId,
                    onError: (Exception e) => print("callbackBackgroundWorkDispatcher(): Unable to fetch data: $e"));
                //removes unnecessary fields like createdAt
                Category cat = Category.fromJson(catResponse.body);
                int newId = await mediaPlayerRepository.saveNewCategory(cat.toMap());
                if (newId != null) {
                  await mediaPlayerRepository.saveLastVersionData(next.version);
                }
                break;
              default:
                print("No case for : " + next.type);
                break;
            }
          }
        }
        break;
      case Workmanager.iOSBackgroundTask:
        print("The iOS background fetch was triggered");
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
/// the job should run twice a day atleast to overcome the second case.
class WorkManagerService {
  void initializeWorker() {
    Workmanager.initialize(callbackBackgroundWorkDispatcher,
        isInDebugMode: true);
  }

  void registerWeeklyTask() {
    Workmanager.registerPeriodicTask(
        Constants.SyncEveryWeek, Constants.SyncEveryWeek,
        constraints: Constraints(
            networkType: NetworkType.connected, requiresBatteryNotLow: true),
        initialDelay: Duration(seconds: 10),
        frequency: Duration(minutes: 15));
  }

  void registerOneTimeTask() {
    Workmanager.registerOneOffTask(
        Constants.SyncEveryWeek, Constants.SyncEveryWeek,
        constraints: Constraints(
            networkType: NetworkType.connected, requiresBatteryNotLow: true));
  }
}
