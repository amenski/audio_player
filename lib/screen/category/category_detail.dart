import 'package:audiobook/model/post.dart';
import 'package:audiobook/repository/media_player_repository.dart';
import 'package:flutter/material.dart';
import 'package:audiobook/model/category.dart';
import 'package:audiobook/util/constants.dart';
import 'package:audiobook/widgets/card/card_tile.dart';
import 'package:audiobook/widgets/image_banner/image_banner.dart';

/// Displays `GridView` of available `Category`
class CategoryDetail extends StatelessWidget {
  final Category _category;
  List<Category> _children;
  var _cardsInRow = 2;

  CategoryDetail(this._category/*, this._children*/);

  @override
  Widget build(BuildContext context) {
    bool landscape = MediaQuery.of(context).orientation == Orientation.landscape;
    if (landscape) {
      _cardsInRow = 3;
    }
    
    return Scaffold(
      appBar: AppBar(title: Text(_category.title)),
      body: FutureBuilder(
        future: MediaPlayerRepository().findChildCategories(_category.id),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Center(child: CircularProgressIndicator());

          _children = snapshot.data;
          return Container(
            child: GridView.builder(
              itemCount: _children.length, 
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: _cardsInRow),
              itemBuilder: (context, index) => _buildCardStack(context, index),
            ),
          );
        },
      ),
    );
  }

  _buildCardStack(BuildContext context, int index) {
    return GestureDetector(
      onTap: () => _onCardTap(context, index),
      child: Padding(
        padding: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0),
        child: Stack(
          alignment: AlignmentDirectional.bottomEnd,
          children: <Widget>[
            ImageBanner(url: _children[index].thumbUrl),
            Container(
              padding: EdgeInsets.symmetric(vertical: 5.0),
              decoration: BoxDecoration(color: Colors.black45.withOpacity(0.7)),
              child: _buildCardTile(context, index),
            ),
          ],
        ),
      ),
    );
  }

  _onCardTap(BuildContext context, int id) async {
    List<Post> postList = await MediaPlayerRepository().findPostByCategory(_children[id].id);
    Navigator.pushNamed(context, Constants.CategoryDetailListPage, arguments: {'title': _category.title, 'data': postList});
  }

  Widget _buildCardTile(BuildContext context, int idx) {
    return CardTile(_children[idx].title, _children[idx].description);
  }
}