import 'package:audiobook/model/category.dart';
import 'package:audiobook/model/post.dart';
import 'package:audiobook/model/version.dart';
import 'package:audiobook/util/constants.dart';
import 'package:http/http.dart';
import 'package:workmanager/workmanager.dart';
import 'package:audiobook/services/backend_sync_service.dart';

/// A top level function(a func outside of a class), used as an entrypoint for flutter WorkManager
void callbackBackgroundWorkDispatcher() {
  Workmanager.executeTask((taskName, inputData) async {
    switch (taskName) {
      case Constants.SyncEveryWeek:
        BackendSyncService beService = BackendSyncService();
        bool required = await beService.isUpdateRequired();
        if(required) {
          Response response = await beService.getNextLatestVersionData(onError: (Exception e) => print("callbackBackgroundWorkDispatcher(): Unable to fetch data: $e"));
          Version next =  Version.fromJson(response.body);
          if(next != null && next.type !=  null) {
            switch(next.type) {
              case "P":
                Response postResponse = await beService.getPostById(next.objectId);
                Post post = Post.fromJson(postResponse.body);
                print("new Post data: " + post.toString());
                break;
              case "C":
                Response catResponse = await beService.getCategoryById(next.objectId);
                Category category = Category.fromJson(catResponse.body);
                print("new Category data: " + category.toString());
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
