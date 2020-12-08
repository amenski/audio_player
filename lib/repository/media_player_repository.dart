import 'package:audiobook/model/category.dart';
import 'package:audiobook/model/post.dart';
import 'package:audiobook/model/version.dart';
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
    print("version to save: "+ version.toString()); //TODO remove
    var db = await dbHandler.getDatabase;
    return await db.rawInsert("insert into version(version) values (?)", [version]);
  }
}