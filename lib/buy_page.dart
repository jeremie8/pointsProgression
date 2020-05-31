import 'package:flutter/material.dart';

import 'activity.dart';

class BuyPage extends StatefulWidget {
  final int points;
  final Function(int) substractPoints;

  const BuyPage({Key key, this.points, this.substractPoints}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _BuyState();
}

class _BuyState extends State<BuyPage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Activity(
          text: "60 minutes de Netflix",
          value: 130,
          callback: widget.substractPoints,
          add: false,
          enabled: widget.points >= 130,
        ),
        Activity(
          text: "60 minutes sur le cell",
          value: 130,
          callback: widget.substractPoints,
          add: false,
          enabled: widget.points >= 130,
        ),
      ],
    );
  }
}
