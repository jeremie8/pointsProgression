import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Activity.dart';

class AddPointsPage extends StatefulWidget {
  final maxProgress;

  const AddPointsPage({Key key, this.maxProgress}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AddPointsState();
}

class _AddPointsState extends State<AddPointsPage> {
  int _progression = 0;

  @override
  void initState() {
    super.initState();
    _loadCounter();
  }

  _resetProgression() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _progression = 0;
      prefs.setInt('progression', _progression);
    });
  }

  //Loading progression value on start
  _loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _progression = (prefs.getInt('progression') ?? 0);
    });
  }

  double percent() => _progression > widget.maxProgress
      ? 1.0
      : _progression / widget.maxProgress;

  void _incrementCounter(int value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _progression = (prefs.getInt('progression') ?? 0) + value;
      prefs.setInt('progression', _progression);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      // Center is a layout widget. It takes a single child and positions it
      // in the middle of the parent.
      child: Column(
        children: <Widget>[
          FlatButton(
            color: Colors.red,
            child: Text("Reset"),
            onPressed: _resetProgression,
          ),
          Expanded(
            flex: 3,
            child: CircularPercentIndicator(
              radius: 200.0,
              lineWidth: 5.0,
              percent: percent(),
              center: Text(percent() >= 1.0
                  ? "Done ($_progression / ${widget.maxProgress})"
                  : "$_progression / ${widget.maxProgress}"),
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
                      callback: _incrementCounter),
                  Activity(
                      text: "30 minutes de biologie",
                      value: 25,
                      callback: _incrementCounter),
                  Activity(
                      text: "30 minutes de physique",
                      value: 30,
                      callback: _incrementCounter),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
