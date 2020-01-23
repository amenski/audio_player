/// Holds constants used in the app, enum's are ommited for the sake of compatibility with earlier version of 
/// dart (< 2.6), since ``extension`` on dart is added in version > 2.6
class Constants {
  static const APP_TITLE = 'Media app';

  static const String DEFAULT_LEADING_IMAGE = 'https://i.ytimg.com/vi/hTzugkbH6fs/maxresdefault.jpg'; //TODO change it to asset
  static const String STORAGE_PERMISSION_DENIED_ERROR = 'Can not download, storage permission denied';

   /// Routes in our app
  static const HomePage = '/';
  static const CategoryDetailPage = '/category-detail';
  static const CategoryDetailListPage = '/category-detail-list';
  static const MediaDetailPage = '/media-detail';

  // Instantiation should not be allowed
  Constants._privateConstructor();
  factory Constants() => null; 
}