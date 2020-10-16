import 'package:age_guesser/view/history/history_details.dart';
import 'package:age_guesser/view_model/history_list.dart';
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
      child: buildHistoryList(),
    );
  }

  Widget buildHistoryList() {
    return Consumer<HistoryListViewModel>(builder: (context, history, child) {
      /// When there are no more entries left in the history show info for the user
      if (history.isEmpty()) {
        return Center(
            child: Text("No history entries available.", style: _biggerFont));
      }

      /// Create List View that displays all entries of the history list in a scrollable and interactive list
      return ListView.separated(
        /// Separator between each entry
        separatorBuilder: (context, index) => Divider(),
        itemCount: history.listSize(),
        padding: EdgeInsets.all(16.0),
        itemBuilder: (BuildContext context, int index) {
          /// Dismissibles allow the user to swipe the entry to perform certain actions
          /// In our case allowing the user to delete the entry by swiping it to the left
          return Dismissible(
            // Only allow swipes to the left
            direction: DismissDirection.endToStart,
            background: Container(
              padding: EdgeInsets.only(right: 20.0),
              alignment: Alignment.centerRight,
              color: Colors.red,

              /// Text that is shown when swiping the list entry to the left
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

            /// Function that is called when the user performs a left swipe on a list entry
            onDismissed: (direction) {
              /// Show notification to the user that an entry was removed
              showDismissedNotification(
                  history.getGuessReversed(index).getName());

              /// Remove the entry
              setState(() {
                history.removeAtReversed(index);
              });
            },
          );
        },
      );
    });
  }

  /// Function that builds a single entry of the list
  Widget _buildRow(Guess guess) {
    return ListTile(
      /// Name as title
      title: Text(guess.getName(), style: _biggerFont),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Age and passed time as subtitles
          Text("Age: " + guess.getAge().toString()),
          Padding(padding: EdgeInsets.symmetric(horizontal: 10.0)),
          Text(guess.getTimePassed()),
        ],
      ),
      trailing: Icon(Icons.keyboard_arrow_right),

      /// Tapping the entry allows the user to open a detailed view of the entry
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => HistoryDetails(
                    guess: guess,
                    context: context,
                    notificationCallback: showDismissedNotification)));
      },
    );
  }

  /// Notification that is shown when an entry was removed from the list
  void showDismissedNotification(String name) {
    Scaffold.of(context).showSnackBar(
        SnackBar(content: Text("Age guess for the name $name removed")));
  }
}
