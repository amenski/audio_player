class Post {
  int _id;
  int _categoryId;
  String _title;
  String _url;
  String _thumbnailUrl;
  String _description;
  bool _downloaded;

  Post(
    this._id, 
    this._title, 
    this._url, 
    this._thumbnailUrl, 
    this._description,
    this._downloaded);

  int get getId => _id;

  String get getTitle => _title;

  String get getUrl => _url;

  String get getThumbnailUrl => _thumbnailUrl;

  String get getDescription => _description;

  bool get isDownloaded => _downloaded;
}
