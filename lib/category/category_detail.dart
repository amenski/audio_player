import 'package:flutter/material.dart';
import 'package:flutter_audio_palyer/model/category.dart';
import 'package:flutter_audio_palyer/util/constants.dart';
import 'package:flutter_audio_palyer/widgets/card/card_tile.dart';
import 'package:flutter_audio_palyer/widgets/image_banner/image_banner.dart';

/// Displays `GridView` of available `Category` or `Post`
class CategoryDetail extends StatelessWidget {
  final category;
  var _cardsInRow = 2;

  CategoryDetail(this.category);

  @override
  Widget build(BuildContext context) {
    bool landscape = MediaQuery.of(context).orientation == Orientation.landscape;
    if (landscape) {
      _cardsInRow = 3;
    }
    
    return Scaffold(
      appBar: AppBar(title: Text(category.title)),
      body: Container(
        child: GridView.builder(
          itemCount: _getItemLength(category), 
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: _cardsInRow),
          itemBuilder: (context, index) => _buildCardStack(context, index),
        ),
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
            ImageBanner(url: category.thumbnailUrl),
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

  _onCardTap(BuildContext context, int id) {
    if(category.categories[id].posts == null){
      // notification here
      return;
    }
    Navigator.pushNamed(context, Constants.CategoryDetailListPage, arguments: {'data': category.categories[id]});
  }

  // only category or posts are available in any moment
  int _getItemLength(Category category ) {
    if(category.categories != null){
      return category.categories.length;
    }
    return category.posts.length;
  }

  Widget _buildCardTile(BuildContext context, int idx) {
    if(category.categories != null){
      return CardTile(category.categories[idx].title, category.categories[idx].description);
    }
    
    return CardTile(category.posts[idx].title, category.posts[idx].description);
  }
}
