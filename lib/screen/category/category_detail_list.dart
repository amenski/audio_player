import 'package:flutter/material.dart';
import 'package:audiobook/model/post.dart';
import 'package:audiobook/screen/media_player/media_detail_widget.dart';

class CategoryDetailList extends StatefulWidget {
  final _title;
  final _postList;

  CategoryDetailList(this._title, this._postList);
  @override
  State<StatefulWidget> createState() => new _CategoryDetailList(this._title, this._postList);

}

class _CategoryDetailList extends State<CategoryDetailList> {
  final List<Post> postList;
  final String title;
  int selectedItemIndex = 0; //current selected item index from the list, hence current playing item
  bool isAutoplaySelected = true;

  /// OnCompleteCallback(int status) on media-player widget
  /// @return 1 (finished/clicked next) or -1 (clicke prev)
  void manageNextAndPreviosSelection(int status) {
    final int newIndex = selectedItemIndex + status;
    if(newIndex < 0) return; //no prev
    if(newIndex > this.postList.length - 1) return; //no next
    
    //TODO autoplay option to be added on next release
    if(isAutoplaySelected) {
      setState(() {
        selectedItemIndex = newIndex;
      });
      mediaPlayerWidget.change(this.postList[selectedItemIndex]);
    }
  }

  MediaDetailWidget mediaPlayerWidget;
  _CategoryDetailList(this.title, this.postList) {
    mediaPlayerWidget = MediaDetailWidget(post: null, onCompleteCallback: (stat) => manageNextAndPreviosSelection(stat));
  }

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
      (this.postList != null && this.postList.isNotEmpty) ? mediaPlayerWidget : new Container() // don't show player controlls
      ]),
    );
  }

   _buildBody(BuildContext context, int index) {
      return new GestureDetector (
              onTap: () => {
                setState(() { 
                  selectedItemIndex = index;
                }),
                mediaPlayerWidget.change(this.postList[index])
              },
              child: ListTile(
                title: Text(postList[index].title),
                subtitle: Text(
                  postList[index].description ?? "",
                  overflow: TextOverflow.ellipsis,
                  ),
                leading: index == selectedItemIndex ? Icon(Icons.play_arrow, color: Colors.redAccent,) : Icon(Icons.music_note, color: Colors.blue,),
                trailing: postList[index].isOpened ? Icon(Icons.check_circle, color: Colors.green,) : null, //Check mark if it was opened
              ),
          );
  }
}