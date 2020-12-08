import 'package:audiobook/model/version.dart';
import 'package:audiobook/repository/media_player_repository.dart';
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
        // TODO continue fetching the new data
        // then only update local version
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
