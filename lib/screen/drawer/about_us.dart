import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  final String descriptionText = "ይህ መተግበርያ መማር/ማንበብ ፈልገው በግዜ ማጣት ወይም መጻሕፍቱን ባለማግኘት ሳያነቡ የቀሯቸውን መጻሕፍትና  ትምህርቶች ከተለያዩ ምንጮች አጠራቅሞ(aggregate) ያቀርባል። ";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("About us")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [

            RichText(
              text: TextSpan(
                text: descriptionText.toString(),
                style: TextStyle(color: Colors.black)
              )
            ),
            Text(""),
            Text("አስተያየት ካሎት በሚከተለው አድራሻ ያገኙናል: amantwd@gmail.com")
          ]
        ),
      )
    );
  }
}