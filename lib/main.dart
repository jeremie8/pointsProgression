import 'package:flutter/material.dart';

import 'app_body.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Points progression',
      theme: ThemeData.dark(),
      home: AppBody(title: "Points progression"),
    );
  }
}
