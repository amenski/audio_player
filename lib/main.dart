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

  //  _getItems() {
  //   var haymanoteAbew1 = Post(
  //     1,
  //     "መቅድም",
  //     "http://debelo.org/debelo_mvc/Audio/HaymanoteAbew/Mekdim.mp3",
  //     description: "መቅድም",
  //   );
    
  //   var haymanoteAbew2 = Post(
  //     2,
  //     "መግለጫ",
  //     "http://debelo.org/debelo_mvc/Audio/HaymanoteAbew/Mekdim.mp3",
  //     description: "መግለጫ",
  //   );
  //   var haymanoteAbew3 = Post(
  //     3,
  //     "ታሪክ",
  //     "http://debelo.org/debelo_mvc/Audio/HaymanoteAbew/Tarik.mp3",
  //     description: "ታሪክ",
  //   );

  //   var haymanoteAbew4 = Post(
  //     3,
  //     "ምዕራፍ ፩",
  //     "http://debelo.org/debelo_mvc/Audio/HaymanoteAbew/Tarik.mp3",
  //     description: "ምዕራፍ ፩",
  //   );

  //   //
  //   var menekosat = Post(
  //     1,
  //     " መግቢያ ፩",
  //     "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/-1.mp3",
  //     description: "መጽሀፈ መነኮሳት ፊልክስዮስ በድምጽ መግቢያ ፩",
  //   );
  //   var menekosat1 = Post(
  //     2,
  //     "መግቢያ ፪",
  //     "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/-2.mp3",
  //     description: "መጽሀፈ መነኮሳት ፊልክስዮስ በድምጽ መግቢያ ፪",
  //   );
  //   var menekosat2 = Post(
  //     3,
  //     "ክፍል 1",
  //     "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/1.mp3",
  //     description: "መጽሀፈ መነኮሳት ፊልክስዮስ ክፍል 1",
  //   );
  //   var menekosat3 = Post(
  //     4,
  //     "ክፍል 2",
  //     "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/2.mp3",
  //     description: "መጽሀፈ መነኮሳት ፊልክስዮስ ክፍል 2",
  //   );
  //   var menekosat4 = Post(
  //     4,
  //     "ክፍል 3",
  //     "http://debelo.org/debelo_mvc/Files/books/meshafemenecosat/Filksyos/3.mp3",
  //     description: "መጽሀፈ መነኮሳት ፊልክስዮስ ክፍል 3",
  //   );

  //   var categoryWithPosts = Category("ሃይማኖተ አበው", "", posts: [haymanoteAbew1, haymanoteAbew2, haymanoteAbew3, haymanoteAbew4]);
  //   var categoryWithPosts2 = Category("መጽሀፈ መነኮሳት ፊልክስዮስ", "", posts: [menekosat, menekosat1, menekosat2, menekosat3, menekosat4]);

  //   var category = Category("በንባብ/ Audio books", "Audio books", categories: [categoryWithPosts, categoryWithPosts2]);
    

  //   return [ category ];
  // }
}