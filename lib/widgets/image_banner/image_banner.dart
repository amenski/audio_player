import 'package:flutter/material.dart';

/// Load image from assets folder or internet
class ImageBanner extends StatelessWidget {
  final String url;
  final double height;

  ImageBanner({this.url, this.height = 200.0,});

  @override
  Widget build(BuildContext context) {
    Widget imageProviderWidget;
    if(url.contains("assets/images")) {
       imageProviderWidget = Image.asset(url, fit: BoxFit.cover,);
    } else {
      imageProviderWidget = Image.network(url, fit: BoxFit.cover,);
    }

    return Container(
      constraints: BoxConstraints.expand(height: height,),
      decoration: BoxDecoration(color: Colors.green), //BoxDecoration: show green box as default in-case data did not arrive
      child: imageProviderWidget
    );
  }
}
