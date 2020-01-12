import 'package:flutter/material.dart';

class ImageBanner extends StatelessWidget {
  final url;
  final double height;

  ImageBanner({this.url, this.height = 200.0});

  @override
  Widget build(BuildContext context) {
    return Container(
        constraints: BoxConstraints.expand(height: height,),
        decoration: BoxDecoration(color: Colors.green), //BoxDecoration: show something default in-case data did not arrive
        child: Image.network(url, fit: BoxFit.cover),
    );
  }
}
