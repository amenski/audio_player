import 'dart:convert';

import 'package:audiobook/util/constants.dart';

class Category {
  int id;
  String title;
  String description;
  int parentCategoryId;
  String thumbUrl;
  String externalId; // _id from mongo, added as a reference to categoryId of Post object
  // BE - holds onetime value which will not be used after fetching the parent.
  String parentCategoryIdBE;

  Category(this.id, this.title, this.description, this.parentCategoryId,
      this.thumbUrl);

  Category.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.title = map['title'];
    this.description = map['description'];
    this.parentCategoryId = map['parent_category_id'];
    this.thumbUrl = map['thumb_url'];
    if (map['thumb_url'] == null) {
      this.thumbUrl = Constants.DEFAULT_LEADING_IMAGE;
    }
    this.externalId = map['_id'];
  }

  Category.fromJson(String json) {
    Map<String, dynamic> map = jsonDecode(json);
    this.title = map['title'];
    this.description = map['description'];
    this.parentCategoryIdBE = map['parentCategoryId'];
    if (map['thumbUrl'] != null && map['thumbUrl'] != "") {
      this.thumbUrl = map['thumbUrl'];
    }
    this.externalId = map['_id'];
  }

  Map<String, dynamic> toMap() {
    return {
      "title": title,
      "description": description,
      "parent_category_id": parentCategoryId,
      "thumb_url": thumbUrl,
      "external_id": externalId,
      "parent_category_id_be": parentCategoryIdBE
    };
  }
}
