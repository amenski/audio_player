import 'dart:async';

import 'package:flutter/material.dart';
import 'package:audiobook/model/category.dart';
import 'package:audiobook/util/constants.dart';
import 'package:audiobook/widgets/card/card_tile.dart';
import 'package:audiobook/util/network_operations.dart';
import 'package:audiobook/services/backend_sync_service.dart';
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
    // service.registerPeriodicTask();
    //service.registerOneTimeTask();
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
      future: _getParentCategoriesFromDbOrRemote(context),
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
    Navigator.pushNamed(context, Constants.CategoryDetailPage, arguments: {'parent': itemsList[id]});
  }

  _buildGrid(BuildContext context, AsyncSnapshot<List<Category>> snapshot) {
      switch(snapshot.connectionState) {
        case ConnectionState.active:
          return Center(child: CircularProgressIndicator());
        case ConnectionState.waiting:
          return Center(child: CircularProgressIndicator());
        case ConnectionState.done:
          itemsList = snapshot.data;
          if(itemsList == null || itemsList.isEmpty) return Center(child: Text("Unkown error! Please try again later."));
          return Container(
            child: GridView.builder(
              itemCount: itemsList.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: _cardsInRow),
              itemBuilder: (context, index) => _buildCardStack(context, index),
            ),
          );
        case ConnectionState.none:
          break;
      }
  }

  Future<List<Category>> _getParentCategoriesFromDbOrRemote(BuildContext context) async {
    BackendSyncService beService = new BackendSyncService();
    NetworkOperations networkOperations = NetworkOperations();

    List<Category> list = await  MediaPlayerRepository().findAllParentCategory();
    if(list != null && list.isNotEmpty) return list;
    //call external api
    final connected = await networkOperations.isConnectedToInternet();
    if(!connected) {
      showSnackBar(context, Constants.NO_INTERNET_CONNECTION_ERROR);
      return Future.value([]);
    }
    await beService.getInitialKit();
    service.registerPeriodicTask(); // must be after fetching initial-kit
    return await  MediaPlayerRepository().findAllParentCategory();
  }

  showSnackBar(BuildContext context, final message) {
    final snackBar = SnackBar(content: Text(message));
    Scaffold.of(context).showSnackBar(snackBar);
  }
}
