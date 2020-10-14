import 'package:flutter/material.dart';

class HistoryDetails extends StatelessWidget {
  final Function removeCallback;
  final int index;

  HistoryDetails({@required this.removeCallback, @required this.index});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Age Guess Details'),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            RaisedButton(
              child: Text('Go Back'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            Padding(padding: EdgeInsets.symmetric(horizontal: 2.0)),

            RaisedButton(
              color: Colors.red,
              child: Text('Remove Entry'),
              onPressed: () {
                removeCallback(index);
                Navigator.pop(context);
              },
            ),
            Padding(padding: EdgeInsets.symmetric(horizontal: 10.0))
          ],
        ),
      ),
    );
  }
}
