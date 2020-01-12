import 'package:flutter/material.dart';
import 'package:flutter_audio_palyer/model/category.dart';
import 'package:flutter_audio_palyer/widgets/card/card_tile.dart';
import '../util/constants.dart';
import '../widgets/image_banner/image_banner.dart';

/// Landing page that displays all categories available
class HomePage extends StatelessWidget {
  final itemsList;
  var _cardsInRow = 2;

  HomePage(this.itemsList);

  @override
  Widget build(BuildContext context) {
    bool landscape = MediaQuery.of(context).orientation == Orientation.landscape;
    if(landscape){
      _cardsInRow = 3;
    }
    return Container(
      child: GridView.builder(
        itemCount: itemsList.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: _cardsInRow),
        itemBuilder: (context, index) => _buildCardStack(context, index),
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
            ImageBanner(url: itemsList[index].getThumbnailUrl),
            Container(
              padding: EdgeInsets.symmetric(vertical: 5.0),
              decoration: BoxDecoration(color: Colors.black45.withOpacity(0.7)),
              child: CardTile(itemsList[index].getTitle, itemsList[index].getDescription)
            ),
          ],
        ),
      ),
    );
  }

  _onCardTap(BuildContext context, int id) {
    //TODO add validation logic
    //_validateCategory(itemsList[id], context);
    Navigator.pushNamed(context, Constants.CategoryDetailPage, arguments: {'data': itemsList[id]});
  }

  // validate if category has a post, or dont display category detail page
  _validateCategory(Category category, BuildContext context) {
    bool valid = (category.getPosts != null || category.getPosts.isEmpty);
    if(!valid) {
      final snackBar = SnackBar(content: Text("Not data found."));
      Scaffold.of(context).showSnackBar(snackBar);
    }
  }
}
