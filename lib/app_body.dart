import 'package:flutter/material.dart';
import 'package:points/add_points_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'buy_page.dart';

class AppBody extends StatefulWidget {
  final String title;

  const AppBody({Key key, this.title}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AppBodyState();
}

class _AppBodyState extends State<AppBody> {
  int _points;
  final String _pointsStr = "points";

  @override
  void initState() {
    super.initState();
    _loadPoints();
  }

  _loadPoints() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _points = (prefs.getInt(_pointsStr) ?? 0);
    });
  }

  void _addPoints(int value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _points = (prefs.getInt(_pointsStr) ?? 0) + value;
      prefs.setInt(_pointsStr, _points);
    });
  }

  void _substractPoints(int value) async {
    _addPoints(-value);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Points : $_points"),
        ),
        body: TabBarView(
          children: [
            AddPointsPage(
              maxProgress: 100,
              points: _points,
              addToPoints: _addPoints,
            ),
            BuyPage(points: _points, substractPoints: _substractPoints,)
          ],
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
