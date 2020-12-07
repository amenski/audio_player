import 'package:audiobook/repository/media_player_repository.dart';
import 'package:audiobook/util/constants.dart';
import 'package:workmanager/workmanager.dart';
import 'package:audiobook/services/backend_sync_service.dart';

/// A top level function(a func outside of a class), used as an entrypoint for flutter WorkManager
void callbackBackgroundWorkDispatcher() {
  Workmanager.executeTask((taskName, inputData) {
    switch (taskName) {
      case Constants.SyncEveryWeek:
        print(Constants.SyncEveryWeek +
            " execution started with data $inputData.");
        BackendSyncService beService = BackendSyncService();
        MediaPlayerRepository repo = new MediaPlayerRepository();
        beService.getVersionData(Constants.LAST_VERSION_EP).then((value) {
          repo.saveLastVersionData(int.parse(value.body)).then((value) => print("Saved latest version value of: " + value.toString()));
        }).catchError((value) =>
            print("printing value from BE server: " + value.toString()));
        break;
      case Workmanager.iOSBackgroundTask:
        print("The iOS background fetch was triggered");
        break;
      default:
        return Future.value(false);
    }
    return Future.value(true);
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
        frequency: Duration(minutes: 15));
  }
}
