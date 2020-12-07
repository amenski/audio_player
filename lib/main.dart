import 'package:audiobook/services/work_manager_service.dart';
import 'package:flutter/material.dart';

import 'screen/category/category_detail.dart';
import 'screen/category/category_detail_list.dart';
import 'screen/home/home.dart';
import 'screen/media_player/media_detail_widget.dart';
import 'util/constants.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    WorkManagerService service = new WorkManagerService();
    service.initializeWorker();
    service.registerWeeklyTask();
    // service.registerOneTimeTask();
    return new MaterialApp(
      onGenerateRoute: _routes(),
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text(Constants.APP_TITLE),
        ),
        body: new HomePage(),
      ),
    );
  }

  RouteFactory _routes() {
    return (settings) {
      final Map<String, dynamic> arguments = settings.arguments;
      Widget screen;
      switch (settings.name) {
        case Constants.HomePage:
          screen = HomePage();
          break;
        case Constants.CategoryDetailPage:
          screen = CategoryDetail(arguments['parent']);
          break;
        case Constants.CategoryDetailListPage:
          screen = CategoryDetailList(arguments['title'], arguments['data']);
          break;
        case Constants.MediaDetailPage:
          screen = MediaDetailWidget(arguments['data']);
          break;
        default:
          return null;
      }
      return MaterialPageRoute(builder: (BuildContext context) => screen);
    };
  }
}
