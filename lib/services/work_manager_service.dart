import 'dart:convert';

import 'package:http/http.dart';
import 'package:audiobook/model/version.dart';
import 'package:workmanager/workmanager.dart';
import 'package:audiobook/util/constants.dart';
import 'package:audiobook/services/backend_sync_service.dart';

/// A top level function(a func outside of a class), used as an entry-point for flutter WorkManager
void callbackBackgroundWorkDispatcher() {
  Workmanager.executeTask((taskName, inputData) async {
    switch (taskName) {
      case Constants.SyncEveryWeek:
      case Constants.SyncEveryDay:
        try {
          BackendSyncService beService = BackendSyncService();
          Response response = await beService.getNextVersionData(onError: (e) => print("callbackBackgroundWorkDispatcher(): Unable to fetch data: $e"));
          if (response != null) {
            Map<String, dynamic> responseData = json.decode(response.body);
            if (responseData["resultCode"] == 200) {
              Version next = Version.fromJson(responseData["returnValue"]);
              await beService.syncData(next);
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
        frequency: Duration(hours: 1));
  }

  void registerOneTimeTask() {
    Workmanager.registerOneOffTask(
        Constants.SyncEveryDay,
        Constants.SyncEveryDay,
        constraints: Constraints(networkType: NetworkType.connected, requiresBatteryNotLow: true));
  }
}
