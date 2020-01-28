import 'package:audiobook/model/category.dart';
import 'package:audiobook/repository/media_player_repository.dart';
import 'package:audiobook/util/constants.dart';
import 'package:audiobook/widgets/card/card_tile.dart';
import 'package:audiobook/widgets/image_banner/image_banner.dart';
import 'package:flutter/material.dart';

/// Landing page that displays all categories available
class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var itemsList;
  var _cardsInRow = 2;

  _HomePageState();

  @override
  void initState() {
    initHomePage();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  // get all parent categories
  void initHomePage() async {
    List<Category> categories = await MediaPlayerRepository().findAllParentCategory();
    setState(() {
      itemsList = categories;
    });
  }

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
            ImageBanner(url: itemsList[index].thumbUrl),
            Container(
              padding: EdgeInsets.symmetric(vertical: 5.0),
              decoration: BoxDecoration(color: Colors.black45.withOpacity(0.7)),
              child: CardTile(itemsList[index].title, itemsList[index].description)
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
  // _validateCategory(Category category, BuildContext context) {
  //   bool valid = (category.posts != null || category.posts.isEmpty);
  //   if(!valid) {
  //     final snackBar = SnackBar(content: Text("Not data found."));
  //     Scaffold.of(context).showSnackBar(snackBar);
  //   }
  // }
}