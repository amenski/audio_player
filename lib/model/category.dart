
import 'package:audiobook/util/constants.dart';

class Category {
  int id;
  String title;
  String description;
  int parentCategoryId;
  String thumbUrl;
  DateTime uploadDate;

  Category(this.id, this.title, this.description, this.parentCategoryId, this.thumbUrl, this.uploadDate);

  Category.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.title = map['title'];
    this.description = map['description'];
    this.parentCategoryId = map['parent_category_id'];
    this.thumbUrl = map['thumb_url'];
    if(map['thumb_url'] == null) {
      this.thumbUrl = Constants.DEFAULT_LEADING_IMAGE;
    }
    this.uploadDate = map['pub_date'];
  }
}