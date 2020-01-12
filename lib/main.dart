import 'package:flutter/material.dart';
import 'package:flutter_audio_palyer/category/category_detail.dart';
import 'package:flutter_audio_palyer/category/category_detail_list.dart';
import 'package:flutter_audio_palyer/model/category.dart';
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
        case Constants.CategoryDetailPage:
          screen = CategoryDetail(arguments['data']);
          break;
        case Constants.CategoryDetailListPage:
          screen = CategoryDetailList(arguments['data']);
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
    var haymanoteAbew1 = Post(
      1,
      "መቅድም",
      "http://debelo.org/debelo_mvc/Audio/HaymanoteAbew/Mekdim.mp3",
      "https://i.ytimg.com/vi/hTzugkbH6fs/maxresdefault.jpg",
      "መቅድም",
      false,
    );
    
    var haymanoteAbew2 = Post(
      2,
      "መግለጫ",
      "http://debelo.org/debelo_mvc/Audio/HaymanoteAbew/Mekdim.mp3",
      "https://i.ytimg.com/vi/hTzugkbH6fs/maxresdefault.jpg",
      "መግለጫ",
      false,
    );
    var haymanoteAbew3 = Post(
      3,
      "ታሪክ",
      "http://debelo.org/debelo_mvc/Audio/HaymanoteAbew/Tarik.mp3",
      "https://i.ytimg.com/vi/hTzugkbH6fs/maxresdefault.jpg",
      "ታሪክ",
      false,
    );

    var haymanoteAbew4 = Post(
      3,
      "ምዕራፍ ፩",
      "http://debelo.org/debelo_mvc/Audio/HaymanoteAbew/Tarik.mp3",
      "https://i.ytimg.com/vi/hTzugkbH6fs/maxresdefault.jpg",
      "ምዕራፍ ፩",
      false,
    );

    //
    var menekosat = Post(
      1,
      " መግቢያ ፩",
      "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/-1.mp3",
      "https://i.ytimg.com/vi/hTzugkbH6fs/maxresdefault.jpg",
      "መጽሀፈ መነኮሳት ፊልክስዮስ በድምጽ መግቢያ ፩",
      false,
    );
    var menekosat1 = Post(
      2,
      "መግቢያ ፪",
      "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/-2.mp3",
      "https://i.ytimg.com/vi/hTzugkbH6fs/maxresdefault.jpg",
      "መጽሀፈ መነኮሳት ፊልክስዮስ በድምጽ መግቢያ ፪",
      false,
    );
    var menekosat2 = Post(
      3,
      "ክፍል 1",
      "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/1.mp3",
      "https://i.ytimg.com/vi/hTzugkbH6fs/maxresdefault.jpg",
      "መጽሀፈ መነኮሳት ፊልክስዮስ ክፍል 1",
      false,
    );
    var menekosat3 = Post(
      4,
      "ክፍል 2",
      "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/2.mp3",
      "https://i.ytimg.com/vi/hTzugkbH6fs/maxresdefault.jpg",
      "መጽሀፈ መነኮሳት ፊልክስዮስ ክፍል 2",
      false,
    );
    var menekosat4 = Post(
      4,
      "ክፍል 3",
      "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/3.mp3",
      "https://i.ytimg.com/vi/hTzugkbH6fs/maxresdefault.jpg",
      "መጽሀፈ መነኮሳት ፊልክስዮስ ክፍል 3",
      false,
    );

    var categoryWithPosts = Category("ሃይማኖተ አበው", "", posts: [haymanoteAbew1, haymanoteAbew2, haymanoteAbew3, haymanoteAbew4]);
    var categoryWithPosts2 = Category("መጽሀፈ መነኮሳት ፊልክስዮስ", "", posts: [menekosat, menekosat1, menekosat2, menekosat3, menekosat4]);

    var category = Category("በንባብ/ Audio books", "Audio books", categories: [categoryWithPosts, categoryWithPosts2]);
    

    return [ category ];
  }
}