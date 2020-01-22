/// A field is equivalent to a getter/setter pair. 
/// A final field is equivalent to a getter.
/// You change it only to actual getters/setters if additionally logic is required (e.g. validation)
class Post {
  int id;
  int categoryId;
  String title;
  String url;
  String thumbnailUrl;
  String description;
  String downloadPath;
  bool isDownloaded = false;

  Post(
    this.id, 
    this.title, 
    this.url, 
    {
      this.thumbnailUrl = "https://i.ytimg.com/vi/hTzugkbH6fs/maxresdefault.jpg", 
      this.description,
      this.downloadPath = '',
      this.isDownloaded = false
    }
    );

}
