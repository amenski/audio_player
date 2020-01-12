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
      appBar: AppBar(title: Text(category.getTitle)),
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
            ImageBanner(url: category.getThumbnailUrl),
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
    if(category.getCategories[id].getPosts == null){
      // notification here
      return;
    }
    Navigator.pushNamed(context, Constants.CategoryDetailListPage, arguments: {'data': category.getCategories[id]});
  }

  // only category or posts are available in any moment
  int _getItemLength(Category category ) {
    if(category.getCategories != null){
      return category.getCategories.length;
    }
    return category.getPosts.length;
  }

  Widget _buildCardTile(BuildContext context, int idx) {
    if(category.getCategories != null){
      return CardTile(category.getCategories[idx].getTitle, category.getCategories[idx].getDescription);
    }
    
    return CardTile(category.getPosts[idx].getTitle, category.getPosts[idx].getDescription);
  }
}
