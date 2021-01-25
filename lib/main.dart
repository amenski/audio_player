import 'package:audiobook/screen/drawer/about_us.dart';
import 'package:flutter/material.dart';
import 'package:audiobook/util/constants.dart';
import 'package:audiobook/screen/home/home.dart';
import 'package:audiobook/screen/drawer/home_drawer.dart';
import 'package:audiobook/screen/category/category_detail.dart';
import 'package:audiobook/screen/category/category_detail_list.dart';

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
        drawer: HomeDrawer(),
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
        case Constants.AboutUsPage:
          screen = AboutUs();
          break;
        default:
          return null;
      }
      return MaterialPageRoute(builder: (BuildContext context) => screen);
    };
  }
}
