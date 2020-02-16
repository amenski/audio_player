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
      child: ListView.builder(
        itemCount: postList.length,
        itemBuilder: (context, index) => _buildBody(context, index),
      ),
    ),
    );
  }

   _buildBody(BuildContext context, int index) {
    return GestureDetector(
      onTap: () => _navigateToDetail(context, index),
      child: ListTile(
        title: Text(postList[index].title),
        subtitle: Text(
          postList[index].description,
          overflow: TextOverflow.ellipsis,
          ),
      ),
    );
  }

  _navigateToDetail(BuildContext context, int id) {
    Navigator.pushNamed(context, Constants.MediaDetailPage, arguments: {'data': postList[id]});
  }
}