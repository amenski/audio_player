import 'package:flutter/material.dart';
import 'package:flutter_audio_palyer/util/constants.dart';
import '../widgets/image_banner/image_banner.dart';

const imageUrl = 'https://i.ytimg.com/vi/hTzugkbH6fs/maxresdefault.jpg';

class HomePage extends StatelessWidget {
  final itemsList = [
    "የደበሎ ድረ-ገጽ ተጠቃሚዎቻችን የሚከቱሉትን",
    "http://debelo.org/debelo_mvc/Audio/_LitonZesebatuEletat/ZeselusSimikeHiyaw.mp3",
    "ትምህርቶች ጨምረናል መስተብቍዕ ዘሌሊት፣መስተብቊዕ በእንተ ዱያን፣መስተብቁዕ በእንተ ፍሬ ምድር"
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: itemsList.length,
        itemBuilder: (context, index) => _buildCardStack(context, index),
      ),
    );
  }

  _buildCardStack(BuildContext context, int index) {
    return GestureDetector(
      onTap: () => _onCardTap(context, index),
      child: Padding(
        padding: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
        child: Stack(
          alignment: AlignmentDirectional.bottomEnd,
          children: <Widget>[
            ImageBanner(url: imageUrl),
            Container(
              padding: EdgeInsets.symmetric(vertical: 5.0),
              decoration: BoxDecoration(color: Colors.blueGrey.withOpacity(0.7)),
              child: ListTile(
                title: Text(
                  itemsList[index],
                  overflow: TextOverflow.ellipsis,
                  textScaleFactor: 1.5,
                ),
                subtitle: Text(
                  itemsList[index],
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _onCardTap(BuildContext context, int id) {
    Navigator.pushNamed(context, Constants.MediaDetailPage, arguments: {'id': id.toString()});
  }
}
