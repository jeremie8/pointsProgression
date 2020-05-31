import 'package:flutter/material.dart';

class Activity extends StatelessWidget {
  final String text;
  final Function(int) callback;
  final bool add;
  final int value;
  final bool enabled;

  const Activity({Key key, this.text, this.callback, this.value, this.add = true, this.enabled = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FlatButton(

          onPressed: enabled ? () => callback(value) : null,
          splashColor: Colors.green,

          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(flex: 5, child: Center(child: Text(text))),
              Expanded(
                flex: 1,
                child: Text((add ? "+" : "-")+ "$value")
              )
            ],
          ),
        ),
      ),
    );
  }
}
