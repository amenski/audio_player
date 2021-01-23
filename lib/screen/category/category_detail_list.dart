import 'package:audiobook/screen/media_player/media_detail_widget.dart';
import 'package:flutter/material.dart';
class CategoryDetailList extends StatefulWidget {
  final _title;
  final _postList;

  CategoryDetailList(this._title, this._postList);
  @override
  State<StatefulWidget> createState() => new _CategoryDetailList(this._title, this._postList);

}

class _CategoryDetailList extends State<CategoryDetailList> {
  final postList;
  final title;
  int selected = 0;

  _CategoryDetailList(this.title, this.postList);
  final MediaDetailWidget mediaPlayerWidget = new MediaDetailWidget(null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(this.title),),
      body: new Column(
        children: [
        new Expanded(
          child: Container(
            color: Colors.blue[50],
            child: ListView.separated(
            shrinkWrap: true,
            itemCount: postList.length,
            separatorBuilder: (BuildContext context, int index) => Divider(indent: 8.0, thickness: 0.8, color: Colors.lightGreen[200],),
            itemBuilder: (context, index) => _buildBody(context, index),
          ),
          ),
        ),
        mediaPlayerWidget
      ]),
    );
  }

   _buildBody(BuildContext context, int index) {
    return new GestureDetector (
            onTap: () => {
              setState((){selected = index;}),
              mediaPlayerWidget.change(this.postList[index]),},
            child: ListTile(
              title: Text(postList[index].title),
              subtitle: Text(
                postList[index].description ?? "",
                overflow: TextOverflow.ellipsis,
                ),
              leading: index == selected ? Icon(Icons.play_circle_outline, color: Colors.blue,) : null,
              trailing: postList[index].isOpened ? Icon(Icons.check_circle, color: Colors.green,) : null, //Check mark if it was opened
            ),
          );
  }
}