
import 'package:flutter_audio_palyer/model/post.dart';
import 'package:flutter_audio_palyer/util/constants.dart';

class Category {
  int _id;
  String _title;
  String _description;
  List<Category> categories;
  List<Post> posts;
  String thumbnailUrl;

  Category(this._title, this._description, {this.categories, this.posts, this.thumbnailUrl = Constants.DEFAULT_LEADING_IMAGE});

  int get getId => _id;
  
  String get getTitle => _title;

  String get getDescription => _description;

  List<Category> get getCategories => categories;

  List<Post> get getPosts => posts;

  String get getThumbnailUrl => thumbnailUrl;
}