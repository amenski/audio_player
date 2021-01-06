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

  Category({
      this.id,
      this.title,
      this.description,
      this.parentCategoryId,
      this.thumbUrl,
      this.externalId,
      this.parentCategoryIdBE
  });

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

  factory Category.fromJson(Map<String, dynamic> parsedCategory) {
    String thumbUrl = Constants.DEFAULT_LEADING_IMAGE;
    if (parsedCategory['thumbUrl'] != null &&
        parsedCategory['thumbUrl'] != "") {
      thumbUrl = parsedCategory['thumbUrl'];
    }
    return Category(
        title: parsedCategory['title'],
        description: parsedCategory['description'],
        parentCategoryIdBE: parsedCategory['parentId'],
        thumbUrl: thumbUrl,
        externalId: parsedCategory['id']
    );
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
