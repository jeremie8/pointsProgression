import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Activity.dart';

class AddPointsPage extends StatefulWidget {
  final maxProgress;
  final Function(int) addToPoints;
  final int points;

  const AddPointsPage({Key key, this.maxProgress, this.addToPoints, this.points}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AddPointsState();
}

class _AddPointsState extends State<AddPointsPage> {
  int _dailyProgression = 0;
  final String _dpString = "dailyProgression";

  @override
  void initState() {
    super.initState();
    _loadDailyProgression();
  }

  _resetDailyProgression() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _dailyProgression = 0;
      prefs.setInt(_dpString, _dailyProgression);
    });
  }

  _loadDailyProgression() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _dailyProgression = (prefs.getInt(_dpString) ?? 0);
    });
  }

  void _incrementDailyProgression(int value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      widget.addToPoints(value);
      _dailyProgression = (prefs.getInt(_dpString) ?? 0) + value;
      prefs.setInt(_dpString, _dailyProgression);
    });
  }

  double percent() => _dailyProgression > widget.maxProgress
      ? 1.0
      : _dailyProgression / widget.maxProgress;

  @override
  Widget build(BuildContext context) {
    return Center(
      // Center is a layout widget. It takes a single child and positions it
      // in the middle of the parent.
      child: Column(
        children: <Widget>[
          FlatButton(
            color: Colors.red,
            child: Text("Reset daily progress"),
            onPressed: _resetDailyProgression,
          ),
          Expanded(
            flex: 3,
            child: CircularPercentIndicator(
              radius: 200.0,
              lineWidth: 5.0,
              percent: percent(),
              center: Text(percent() >= 1.0
                  ? "Done ($_dailyProgression / ${widget.maxProgress})"
                  : "$_dailyProgression / ${widget.maxProgress}"),
              progressColor: percent() >= 1.0 ? Colors.green : Colors.red,
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
              child: ListView(
                children: <Widget>[
                  Activity(
                      text: "30 minutes de chimie",
                      value: 25,
                      callback: _incrementDailyProgression),
                  Activity(
                      text: "30 minutes de biologie",
                      value: 25,
                      callback: _incrementDailyProgression),
                  Activity(
                      text: "30 minutes de physique",
                      value: 30,
                      callback: _incrementDailyProgression),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
