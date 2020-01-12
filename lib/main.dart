import 'package:flutter/material.dart';
import 'package:flutter_audio_palyer/widgets/media_player/media_detail_widget.dart';
import 'model/post.dart';
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
        body: new HomePage(_getItems()),
      ),
    );
  }

  RouteFactory _routes() {
    return (settings) {
      final Map<String, dynamic> arguments = settings.arguments;
      Widget screen;
      switch (settings.name) {
        case Constants.HomePage:
          screen = HomePage([]);
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

   _getItems() {
    var post = Post(
      1,
      "የደበሎ ድረ-ገጽ ተጠቃሚዎቻችን የሚከቱሉትን",
      "http://debelo.org/debelo_mvc/Audio/_LitonZesebatuEletat/ZeselusSimikeHiyaw.mp3",
      "https://i.ytimg.com/vi/hTzugkbH6fs/maxresdefault.jpg",
      "ትምህርቶች ጨምረናል መስተብቍዕ ዘሌሊት፣መስተብቊዕ በእንተ ዱያን፣መስተብቁዕ በእንተ ፍሬ ምድር",
      false,
    );
    return [ post, post, post,post ];
  }
}