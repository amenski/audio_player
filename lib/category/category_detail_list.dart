import 'package:flutter/material.dart';
import 'package:flutter_audio_palyer/util/constants.dart';

class CategoryDetailList extends StatelessWidget {
  var category;

  CategoryDetailList(this.category);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(category.getTitle),),
      body: Container(
      child: ListView.builder(
        itemCount: category.getPosts.length,
        itemBuilder: (context, index) => _buildBody(context, index),
      ),
    ),
    );
  }

   _buildBody(BuildContext context, int index) {
    return GestureDetector(
      onTap: () => _navigateToDetail(context, index),
      child: ListTile(
        title: Text(category.getPosts[index].getTitle),
        subtitle: Text(
          category.getPosts[index].getDescription,
          overflow: TextOverflow.ellipsis,
          ),
      ),
    );
  }

    _navigateToDetail(BuildContext context, int id) {
    Navigator.pushNamed(context, Constants.MediaDetailPage, arguments: {'data': category.getPosts[id]});
  }
}