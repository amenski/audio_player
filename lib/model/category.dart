
import 'package:audiobook/util/constants.dart';

class Category {
  int _id;
  String _title;
  String _description;
  int _parentCategoryId;
  String _thumbUrl  = Constants.DEFAULT_LEADING_IMAGE;

  Category(this._id, this._title, this._description, this._parentCategoryId, this._thumbUrl);

  int get getId => this._id;

  set setId(int id) => this._id = id;

  String get getTitle => this._title;

  set setTitle(String title) { 
    if(title.length < 255) {
      this._title = title;
    }
  }

  String get getDescription => this._description;

  set setDescription(String description) => this._description = description;

  int get getParentCategoryId => this._parentCategoryId;

  set setParentCategoryId(int id) => this._parentCategoryId = id;

  String get getThumbUrl => this._thumbUrl;

  set setThumbUrl(String url) => this._thumbUrl = url;

  ///
  Category.fromMap(Map<String, dynamic> map) { //TODO to verify
    this._id = map['id'];
    this._title = map['title'];
    this._description = map['description'];
    this._parentCategoryId = map['parent_category_id'];
    this._thumbUrl = map['thumb_url'];
  }
}