import 'package:flutter/material.dart';
import 'package:audiobook/util/constants.dart';
import 'package:audiobook/screen/home/home.dart';
import 'package:audiobook/screen/category/category_detail.dart';
import 'package:audiobook/screen/category/category_detail_list.dart';
import 'package:audiobook/screen/media_player/media_detail_widget.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
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
