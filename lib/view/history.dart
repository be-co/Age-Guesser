import 'package:age_guesser/services/storage.dart';
import 'package:age_guesser/view/history_details.dart';
import 'package:flutter/material.dart';

import 'package:age_guesser/model/guess.dart';
import 'package:age_guesser/model/guess_history.dart';

class History extends StatefulWidget {
  History({Key key}) : super(key: key);

  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
 /* final List<Guess> history = <Guess>[
    Guess(name: 'Bernd', age: 32),
    Guess(name: 'Martin', age: 30),
    Guess(name: 'Lars', age: 24)
  ]; */
  final TextStyle _biggerFont = TextStyle(fontSize: 18.0);

  GuessHistory history;
  List<Guess> historyList;

  @override
  void initState() {
    GuessHistory history = loadHistory();
    historyList = history.getGuessHistory();
    this.history = history;
    super.initState();
  }

  @override
  void dispose() {
    saveHistory(history);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // When there are no more entries left in the history show info for the user
      child: historyList.length > 0 ? buildHistoryList() : Text("No history entries available."),
    );
  }

  //TODO if list is empty show message

  Widget buildHistoryList() {
    return ListView.separated(
      separatorBuilder: (context, index) => Divider(),
      itemCount: historyList.length,
      padding: EdgeInsets.all(16.0),
      itemBuilder: (BuildContext context, int index) {
        return Dismissible(
          // Only allow swipes to the left
          direction: DismissDirection.endToStart,
          background: Container(
            padding: EdgeInsets.only(right: 20.0),
            alignment: Alignment.centerRight,
            color: Colors.red,
            child: Text(
              'Delete',
              textAlign: TextAlign.right,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          key: Key(historyList[index].getTimeStamp().toString()),
          child: Container(
            //height: 70,
            // color: Colors.white,
            child: _buildRow(historyList[index], index),
          ),
          onDismissed: (direction) {
            Scaffold.of(context).showSnackBar(
                SnackBar(content: Text("Age guess for the name ${historyList[index].getName()} removed")));
            setState(() {
              historyList.removeAt(index);
            });
          },
        );
        /*if (i.isOdd) return Divider();

        final index = i ~/ 2;
        if (index >= history.length) {} */
        //return _buildRow(history[index]);
      },
    );
  }

  Widget _buildRow(Guess guess, int index) {
    return ListTile(
      title: Text(guess.getName(), style: _biggerFont),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Age: " + guess.getAge().toString()),
          Padding(padding: EdgeInsets.symmetric(horizontal: 10.0)),
          Text("<1 min ago"),
        ],
      ),
      trailing: Icon(Icons.keyboard_arrow_right),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => HistoryDetails(removeCallback: removeGuess, index: index)));
      },
    );
  }

  void removeGuess(int index) {
    setState(() {
      historyList.removeAt(index);
      Scaffold.of(context).showSnackBar(
                SnackBar(content: Text("Age guess removed")));
      //print("removed + size: " + historyList.length.toString());
    });
  }
}
