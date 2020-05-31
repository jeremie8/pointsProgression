import 'package:flutter/material.dart';
import 'package:points/add_points_page.dart';

import 'buy_page.dart';

class AppBody extends StatelessWidget{
  final String title;

  const AppBody({Key key, this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: TabBarView(
          children: [AddPointsPage(maxProgress: 100,), BuyPage()],
        ),
        bottomNavigationBar: TabBar(
          tabs: [
            Tab(
              icon: Icon(Icons.add),
              child: Text("Add"),
            ),
            Tab(
              icon: Icon(Icons.remove),
              child: Text("Buy"),
            ),
          ],
        ),
      ),
    );
  }

}

