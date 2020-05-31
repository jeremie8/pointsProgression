import 'package:flutter/material.dart';

class Activity extends StatelessWidget {
  final String text;
  final Function(int) callback;
  final int value;

  const Activity({Key key, this.text, this.callback, this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FlatButton(
          onPressed: () => callback(value),
          splashColor: Colors.green,

          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(flex: 5, child: Center(child: Text(text))),
              Expanded(
                flex: 1,
                child: Text("+$value")
              )
            ],
          ),
        ),
      ),
    );
  }
}
