// Holds constants used in the app, enum's are ommited for the sake of compatibility with earlier version of// @dart (< 2.6), since ``extension`` on dart is added in version > 2.6

class Constants {
  static const APP_TITLE = 'Audio Book/መፅሐፍት በድምፅ';

  static const String DEFAULT_LEADING_IMAGE = 'assets/images/reading-book.jpg';

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
  static const SyncEveryDay = "syncEveryDay";
  static const String BE_IP ="http://192.168.1.9:8080/v1"; //10.0.2.2 Special alias to your host loopback interface (i.e., 127.0.0.1 on your development machine)
  static const String VERSION_EP = BE_IP + '/version';
  static const String INITIAL_DATA_EP = VERSION_EP + '/initial-kit';

  static const String CATEGORY_EP = BE_IP + '/category';

  static const String POST_EP = BE_IP + '/post';

  // Instantiation should not be allowed
  Constants._();
  factory Constants() => null; 
}