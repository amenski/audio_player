import 'package:flutter/material.dart';

/// A field is equivalent to a getter/setter pair. 
/// A final field is equivalent to a getter.
/// You change it only to actual getters/setters if additionally logic is required (e.g. validation)
class Post {
  int id;
  int categoryId;
  String title;
  String url;
  String thumbUrl;
  String description;
  String downloadPath;
  bool isDownloaded = false;

  Post(
    {
      @required this.id, 
      @required this.title, 
      @required this.url, 
      this.thumbUrl = "https://i.ytimg.com/vi/hTzugkbH6fs/maxresdefault.jpg", 
      this.description,
      this.downloadPath = '',
      this.isDownloaded = false
    }
    );

}
