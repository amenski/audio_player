import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:audiobook/util/constants.dart';
import 'package:url_launcher/url_launcher.dart';


class HomeDrawer extends StatelessWidget {
  final Map<String, String> map;
  HomeDrawer({Key key, this.map}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(''),
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/audio_book_1.jpg"),
                  fit: BoxFit.cover)
            ),
            ),
          ListTile(
            dense: true,
            leading:Icon(Icons.share),
            title: Text('Share', style: TextStyle(color: Colors.black), overflow: TextOverflow.ellipsis),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
              Share.share("ይህንን መተግበርያ ይመልከቱት፣ በጣም ጠቃሚ ነው " + Constants.APP_ID);
            },
          ),
          ListTile(
            dense: true,
            leading: Icon(Icons.thumb_up),
            title: Text('Rate us', style: TextStyle(color: Colors.black), overflow: TextOverflow.ellipsis),
            onTap: () {
              Navigator.pop(context);
              launch(Constants.APP_ID);
            },
          ),ListTile(
            dense: true,
            leading: Icon(Icons.water_damage),
            title: Text('About', style: TextStyle(color: Colors.black), overflow: TextOverflow.ellipsis),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, Constants.AboutUsPage);
            },
          ),
        ],
      ),
    );
  }
}
