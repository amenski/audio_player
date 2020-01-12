import 'package:flutter/material.dart';
import '../util/constants.dart';
import '../widgets/image_banner/image_banner.dart';

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
              decoration:
                  BoxDecoration(color: Colors.black45.withOpacity(0.7)),
              child: ListTile(
                dense: true,
                title: Text(
                  itemsList[index].getTitle,
                  style: TextStyle(color: Colors.white),
                  overflow: TextOverflow.ellipsis
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _onCardTap(BuildContext context, int id) {
    Navigator.pushNamed(context, Constants.MediaDetailPage, arguments: {'data': itemsList[id]});
  }
}
