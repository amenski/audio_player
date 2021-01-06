import 'package:flutter/material.dart';
import 'package:audiobook/util/constants.dart';

class CategoryDetailList extends StatelessWidget {
  final postList;
  final title;

  CategoryDetailList(this.title, this.postList);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(this.title),),
      body: Container(
        color: Colors.grey[40],
        child: ListView.separated(
          itemCount: postList.length,
          separatorBuilder: (BuildContext context, int index) => Divider(indent: 8.0, thickness: 0.8, color: Colors.lightGreen[200],),
          itemBuilder: (context, index) => _buildBody(context, index),
        ),
      ),
    );
  }

   _buildBody(BuildContext context, int index) {
    return GestureDetector (
      onTap: () => _navigateToDetail(context, index),
        child: ListTile(
          title: Text(postList[index].title),
          subtitle: Text(
            postList[index].description ?? "",
            overflow: TextOverflow.ellipsis,
            ),
            trailing: postList[index].isOpened ? Icon(Icons.check_circle, color: Colors.green,) : null, //Check mark if it was opened
        ),
    );
  }

  _navigateToDetail(BuildContext context, int id) {
    Navigator.pushNamed(context, Constants.MediaDetailPage, arguments: {'data': postList[id]});
  }
}