import 'package:audiobook/model/post.dart';
import 'package:audiobook/model/version.dart';
import 'package:audiobook/model/category.dart';
import 'package:audiobook/util/db_handler.dart';

class MediaPlayerRepository {

  DatabaseHandler dbHandler = DatabaseHandler(); // factory instantiated singleton
  
  // the Future returns List<Map<String, dynamic>> where the map holds all columns and their values as individual entries 
  Future<List<Category>> findAllParentCategory() async {
    var db = await dbHandler.getDatabase;
    return await db.rawQuery('select * from category where parent_category_id is null').then((list) => list.map((row) => Category.fromMap(row)).toList());
  }
 
  Future<Category> findByCategoryId(int id) async {
    var db = await dbHandler.getDatabase;
    return await db.rawQuery('select * from category where id = $id ').then((list) => Category.fromMap(list.first));
  }

  Future<List<Category>> findChildCategories(int parentId) async {
    var db = await dbHandler.getDatabase;
    return await db.rawQuery('select * from category where parent_category_id = $parentId ').then((list) => list.map((val) => Category.fromMap(val)).toList());
  }

  /// POSTS
  Future<List<Post>> findPostByCategory(int catId) async {
    var db = await dbHandler.getDatabase;
    return await db.rawQuery('select * from post where category_id = $catId ').then((list) => list.map((val) => Post.fromMap(val)).toList());
  }

   /// POST update
  updatePostOpened(int pId, int catId) async {
    var db = await dbHandler.getDatabase;
    db.rawQuery('update post set is_opened = 1 where (id = $pId and category_id = $catId)');
  }

  // === BE related ===
  Future<Version> getLastVersionData() async {
    var db = await dbHandler.getDatabase;
    List<Map<String, dynamic>> val = await db.rawQuery("select * from version limit 1");
    return Version.fromMap(val.first);
  }

  Future<int> saveLastVersionData(int version) async {
    var db = await dbHandler.getDatabase;
    return await db.rawUpdate("update version set version = ? where id=1", [version]);
  }

  // save nested post from BE on a separate table,
  // the client and BE have model difference
  Future<int> saveNewCategory(Map<String, dynamic> category) async {
    var db = await dbHandler.getDatabase;
    String parent = category['parent_category_id_be']; //will not be saved
    category.remove('parent_category_id_be'); // remove or else it is an exception
    if(parent != null) {
      List<Map<String, dynamic>> values = await db.rawQuery("select id from category where external_id = ?", [parent]);
      category["parent_category_id"] = values[0]["id"];
    }
    return await db.insert("category", category);
  }

  Future<int> saveNewPost(Map<String, dynamic> post) async {
    var db = await dbHandler.getDatabase;
    // no autoincrement for non-primary keys, so use MAX,
    // select MAX(id) from post where category_id = "category_id";
    String insertString ="insert into post (id, category_id, title, url, thumb_url, description) "
        + " values((select IFNULL(MAX(id), 0) + 1 from post where category_id = ${post['category_id']}), ?, ?, ?, ?, ?)";
    return await db.rawInsert(insertString, [post['category_id'], post['title'], post['url'], post['thumb_url'], post['description']]);
  }

  Future<Category> findCategoryByExternalId(String externalId) async {
    var db = await dbHandler.getDatabase;
    List<Map<String, dynamic>> values = await db.rawQuery("select * from category where external_id = ? limit 1", [externalId]);
    return Category.fromMap(values[0]);
  }
}