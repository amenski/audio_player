import 'package:flutter/material.dart';
import 'package:audiobook/model/category.dart';
import 'package:audiobook/util/constants.dart';
import 'package:audiobook/widgets/card/card_tile.dart';
import 'package:audiobook/services/work_manager_service.dart';
import 'package:audiobook/widgets/image_banner/image_banner.dart';
import 'package:audiobook/repository/media_player_repository.dart';

/// Landing page that displays all categories available
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Category> itemsList;
  var _cardsInRow = 2;
  //background service
  WorkManagerService service = new WorkManagerService();

  _HomePageState();

  @override
  void initState() {
    super.initState();
    service.initializeWorker();
    service.registerPeriodicTask();
//     service.registerOneTimeTask();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool landscape = MediaQuery.of(context).orientation == Orientation.landscape;
    if (landscape) {
      _cardsInRow = 3;
    }
    return FutureBuilder(
      future: MediaPlayerRepository().findAllParentCategory(), // get all parent categories
      builder: (context, AsyncSnapshot<List<Category>> snapshot) {
       return _buildGrid(context, snapshot);
      },
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
                child: CardTile(itemsList[index].title, itemsList[index].description)),
          ],
        ),
      ),
    );
  }

  _onCardTap(BuildContext context, int id) async {
    service.registerOneTimeTask();
    Navigator.pushNamed(context, Constants.CategoryDetailPage, arguments: {'parent': itemsList[id]});
  }

  _buildGrid(BuildContext context, AsyncSnapshot<List<Category>> snapshot) {
    if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
    // should I add 50 versions as initial download?
    itemsList = snapshot.data;
    return Container(
      child: GridView.builder(
        itemCount: itemsList.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: _cardsInRow),
        itemBuilder: (context, index) => _buildCardStack(context, index),
      ),
    );
  }
}
