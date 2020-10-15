import 'package:age_guesser/view/history/history_details.dart';
import 'package:age_guesser/view_model/history_list_view_model.dart';
import 'package:flutter/material.dart';

import 'package:age_guesser/model/guess.dart';
import 'package:provider/provider.dart';

class History extends StatefulWidget {
  History({Key key}) : super(key: key);

  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  final TextStyle _biggerFont = TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context) {
    return Container(
      // When there are no more entries left in the history show info for the user
      child: buildHistoryList(),
    );
  }

  //TODO if list is empty show message

  Widget buildHistoryList() {
    return Consumer<HistoryListViewModel>(builder: (context, history, child) {
      if (history.isEmpty()) {
        return Text("No history entries available.");
      }
      return ListView.separated(
        separatorBuilder: (context, index) => Divider(),
        itemCount: history.listSize(),
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
            key: Key(history.getGuessReversed(index).getTimeStamp().toString()),
            child: Container(
              child: _buildRow(history.getGuessReversed(index)),
            ),
            onDismissed: (direction) {
              showDismissedNotification(history.getGuessReversed(index).getName());
              setState(() {
                history.removeAtReversed(index);
              });
            },
          );
        },
      );
    });
  }

  Widget _buildRow(Guess guess) {
    return ListTile(
      title: Text(guess.getName(), style: _biggerFont),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Age: " + guess.getAge().toString()),
          Padding(padding: EdgeInsets.symmetric(horizontal: 10.0)),
          Text(guess.getTimePassed()),
        ],
      ),
      trailing: Icon(Icons.keyboard_arrow_right),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => HistoryDetails(guess: guess, context: context)));
      },
    );
  }

  void showDismissedNotification(String name) {
    Scaffold.of(context).showSnackBar(
        SnackBar(content: Text("Age guess for the name $name removed")));
  }

  void removeGuess(Guess guess) {
    setState(() {
      Provider.of<HistoryListViewModel>(context).remove(guess);
      Scaffold.of(context).showSnackBar(SnackBar(
          content: Text("Age guess for " + guess.getName() + " removed")));
    });
  }
}
