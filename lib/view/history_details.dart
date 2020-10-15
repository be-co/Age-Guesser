import 'package:age_guesser/model/guess.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HistoryDetails extends StatelessWidget {
  final Function removeCallback;
  final Guess guess;

  HistoryDetails(
      {@required this.removeCallback,
      @required this.guess});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Age Guess Details'),
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
            decoration: BoxDecoration(
              //border: Border.all(color: Colors.black),
              color: Colors.blue,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: Column(
                children: [
                  Text(
                    "Name:",
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 18.0,
                        color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  Padding(padding: const EdgeInsets.symmetric(vertical: 4.0)),
                  Text(
                    guess.getName(),
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 32.0,
                        color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  Padding(padding: const EdgeInsets.symmetric(vertical: 10.0)),
                  Text(
                    "Guessed age:",
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 18.0,
                        color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  Padding(padding: const EdgeInsets.symmetric(vertical: 4.0)),
                  Text(
                    guess.getAge().toString(),
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 32.0,
                        color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  Padding(padding: const EdgeInsets.symmetric(vertical: 10.0)),
                  Text(
                    "Date of guess:",
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 18.0,
                        color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  Padding(padding: const EdgeInsets.symmetric(vertical: 4.0)),
                  Text(
                    new DateFormat.yMMMd().add_jm().format(guess.getTimeStamp()),
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 32.0,
                        color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 4.0),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(padding: EdgeInsets.symmetric(horizontal: 5.0)),
              Expanded(
                              child: RaisedButton(
                  child: Text('Go Back'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              Padding(padding: EdgeInsets.symmetric(horizontal: 2.0)),
              Expanded(
                              child: RaisedButton(
                  color: Colors.red,
                  child: Text('Remove Entry'),
                  onPressed: () {
                    removeCallback(guess);
                    Navigator.pop(context);
                  },
                ),
              ),
              Padding(padding: EdgeInsets.symmetric(horizontal: 5.0)),
            ],
          ),
        ],
      ),
    );
  }
}
