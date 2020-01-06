import 'package:flutter/material.dart';
import 'package:flutter_audio_palyer/widgets/media_player/media_detail_widget.dart';
import 'util/constants.dart';
import 'home/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
        case Constants.MediaDetailPage:
          screen = MediaDetailWidget(arguments['id']);
          break;
        default:
          return null;
      }
      return MaterialPageRoute(builder: (BuildContext context) => screen);
    };
  }
}