/// Holds constants used in the app, enum's are ommited for the sake of compatibility with earlier version of 
/// dart (< 2.6), since ``extension`` on dart is added in version > 2.6
class Constants {
  static const APP_TITLE = 'Media app';

  static const String DEFAULT_LEADING_IMAGE = 'assets/images/default.jpg';


   /// Routes in our app
  static const HomePage = '/';
  static const MediaDetailPage = '/media-detail';

  // Instantiation should not be allowed
  Constants._privateConstructor();
  factory Constants() => null; 
}