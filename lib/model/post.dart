class Post {
  int _id;
  String _title;
  String _url;
  String _thumbnailUrl;
  String _description;
  bool _downloaded;

  Post(this._id, this._title, this._url, this._thumbnailUrl, this._description,
      this._downloaded);

  int get getId => _id;

  String get getTitle => _title;

  String get getUrl => _url;

  String get getThumbnailUrl => _thumbnailUrl;

  String get getDescription => _description;

  bool get isDownloaded => _downloaded;

  Post.mock() {
    Post(
      1,
      "የደበሎ ድረ-ገጽ ተጠቃሚዎቻችን የሚከቱሉትን",
      "http://debelo.org/debelo_mvc/Audio/_LitonZesebatuEletat/ZeselusSimikeHiyaw.mp3",
      "https://i.ytimg.com/vi/hTzugkbH6fs/maxresdefault.jpg",
      "ትምህርቶች ጨምረናል መስተብቍዕ ዘሌሊት፣መስተብቊዕ በእንተ ዱያን፣መስተብቁዕ በእንተ ፍሬ ምድር",
      false,
    );
  }
}
