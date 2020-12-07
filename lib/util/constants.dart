/// Holds constants used in the app, enum's are ommited for the sake of compatibility with earlier version of 
// @dart (< 2.6), since ``extension`` on dart is added in version > 2.6

class Constants {
  static const APP_TITLE = 'Audio Book/መፅሐፍት በድምፅ';

  static const String DEFAULT_LEADING_IMAGE = 'https://i.ytimg.com/vi/hTzugkbH6fs/maxresdefault.jpg'; //TODO change it to asset

  static const String STORAGE_PERMISSION_DENIED_ERROR = 'Can not download, storage permission denied';
  static const String MEDIA_ALREADY_DOWNLOADED = 'Already downloaded!.';
  static const String FEATURE_NOT_AVAILABLE = 'This feature will be available soon.';
  static const String NO_INTERNET_CONNECTION_ERROR = 'No internet, please make sure have internet access.';

  static const String DATABASE_FILE_NAME = "database.db";
  
  /// Routes in our app
  static const HomePage = '/';
  static const CategoryDetailPage = '/category-detail';
  static const CategoryDetailListPage = '/category-detail-list';
  static const MediaDetailPage = '/media-detail';

  // BE
  static const SyncEveryWeek = "syncEveryWeekPeriodicWork";
  static const String BE_IP ="http://192.168.1.8:4000/api";
  static const String LAST_VERSION_EP = BE_IP + '/version/last-version';


  // Instantiation should not be allowed
  Constants._privateConstructor();
  factory Constants() => null; 
}