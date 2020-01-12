import 'package:flutter/material.dart';

class CardTile extends StatelessWidget {
  String _title;
  String _subtitle;

  CardTile(this._title, this._subtitle);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      title: Text(_title,
          style: TextStyle(color: Colors.white),
          overflow: TextOverflow.ellipsis),
    );
  }
}
