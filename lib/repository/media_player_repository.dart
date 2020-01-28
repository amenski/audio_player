import 'package:audiobook/model/category.dart';
import 'package:audiobook/util/db_handler.dart';

class MediaPlayerRepository {

  DatabaseHandler dbHandler = DatabaseHandler(); // factory instantiated singleton
  
  // the Future returns List<Map<String, dynamic>> where a map holds all columns of a single row 
  Future<List<Category>> findAllParentCategory() async {
    var db = await dbHandler.getDatabase;
    return await db.rawQuery('select * from category where parent_category_id is null').then((list) => list.map((row) => Category.fromMap(row)).toList());
  }
 
  Future<Category> findByCategoryId(int id) async {
    var db = await dbHandler.getDatabase;
    return await db.rawQuery('select * from category where id = $id ').then((list) => Category.fromMap(list.first));
  }

  Future<List<Category>> findByParentCategoryId(int id) async {
    var db = await dbHandler.getDatabase;
    return await db.rawQuery('select * from category where parent_category_id = $id ').then((list) => list.map((val) => Category.fromMap(list.first)).toList());
  }

}