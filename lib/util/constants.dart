/// Holds constants used in the app, enum's are ommited for the sake of compatibility with earlier version of 
/// dart (< 2.6), since ``extension`` on dart is added in version > 2.6
class Constants {
  static const APP_TITLE = 'Media app';

  static const String DEFAULT_LEADING_IMAGE = "https://thumbs.worthpoint.com/zoom/images2/1/0713/14/ethiopian-tewahedo-orthodox-christian_1_a2c0192e16c896231694b5775bfd8513.jpg"; //TODO change it to asset


   /// Routes in our app
  static const HomePage = '/';
  static const CategoryDetailPage = '/category-detail';
  static const CategoryDetailListPage = '/category-detail-list';
  static const MediaDetailPage = '/media-detail';

  // Instantiation should not be allowed
  Constants._privateConstructor();
  factory Constants() => null; 
}