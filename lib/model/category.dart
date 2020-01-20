
import 'package:flutter_audio_palyer/model/post.dart';
import 'package:flutter_audio_palyer/util/constants.dart';

class Category {
  int id;
  String title;
  String description;
  List<Category> categories;
  List<Post> posts;
  String thumbnailUrl;

  Category(
    this.title, 
    this.description, 
    {
      this.categories, 
      this.posts, 
      this.thumbnailUrl = Constants.DEFAULT_LEADING_IMAGE
    }
  );

}