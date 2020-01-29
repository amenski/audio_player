import 'package:audiobook/util/constants.dart';
import 'package:flutter/material.dart';

/// A field is equivalent to a getter/setter pair. 
/// A final field is equivalent to a getter.
/// You change it only to actual getters/setters if additionally logic is required (e.g. validation)
class Post {
  int id;
  int categoryId;
  String title;
  String url;
  String thumbUrl = Constants.DEFAULT_LEADING_IMAGE;
  String description;
  String downloadPath;
  bool isDownloaded = false;

  Post(this.id, this.categoryId, this.title, this.url, this.thumbUrl, this.description, this.downloadPath, this.isDownloaded);

  Post.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.categoryId = map['category_id'];
    this.title = map['title'];
    this.url = map['url'];
    if(map['thumb_url'] != null) {
      this.thumbUrl = map['thumb_url'];
    }
    this.description = map['description'];
    this.downloadPath = map['download_path'];
    this.isDownloaded = (map['is_downloaded'] == 1) ? true : false;
  }
}
