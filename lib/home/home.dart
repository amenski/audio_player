import 'package:flutter/material.dart';
import '../widgets/image_banner/image_banner.dart';

const imageUrl =
    'https://i.ytimg.com/vi/hTzugkbH6fs/maxresdefault.jpg';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[_buildCardStack(), _buildCardStack()],
      ),
    );
  }

  _buildCardStack() {
    return Padding(
      padding: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
      child: Stack(
        alignment: AlignmentDirectional.bottomEnd,
        children: <Widget>[
          ImageBanner(
            url: imageUrl,
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 5.0),
            decoration: BoxDecoration(color: Colors.black.withOpacity(0.5)),
            child: ListTile(
              title: Text(
                "የደበሎ ድረ-ገጽ ተጠቃሚዎቻችን የሚከቱሉትን",
                overflow: TextOverflow.ellipsis,
                textScaleFactor: 1.5,
              ),
              subtitle: Text(
                "ትምህርቶች ጨምረናል መስተብቍዕ ዘሌሊት፣መስተብቊዕ በእንተ ዱያን፣መስተብቁዕ በእንተ ፍሬ ምድር",
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
