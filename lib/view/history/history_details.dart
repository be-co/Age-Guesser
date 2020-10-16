import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:age_guesser/model/guess.dart';
import 'package:age_guesser/view/history/details_value.dart';
import 'package:age_guesser/view/history/two_button_row.dart';
import 'package:age_guesser/view_model/history_list.dart';

/// Widget that shows the details of an guess selected by the user in the history list
class HistoryDetails extends StatelessWidget {
  final Guess guess;
  final BuildContext context;
  final Function notificationCallback;

  HistoryDetails({@required this.guess, @required this.context, @required this.notificationCallback});

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
                  DetailsValue(
                      title: 'Name: ',
                      value: guess.getName(),
                      usePadding: true),
                  DetailsValue(
                      title: 'Guessed Age: ',
                      value: guess.getAge().toString(),
                      usePadding: true),
                  DetailsValue(
                      title: 'Date of Guess: ',
                      /// Format timestamp into a user readable format
                      value: new DateFormat.yMMMd()
                          .add_jm()
                          .format(guess.getTimeStamp()),
                      usePadding: false),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 4.0),
          ),
          TwoButtonRow(
            positiveButtonText: 'Go Back',
            negativeButtonText: 'Remove Entry',
            positiveButtonCallback: goBack,
            negativeButtonCallback: removeEntry,
          ),
        ],
      ),
    );
  }

  /// Return to the previous screen
  void goBack() {
    Navigator.pop(context);
  }

  /// Removes a guess from the underlying history list, shows a notification and returns to the previous screen
  void removeEntry() {
    Provider.of<HistoryListViewModel>(context, listen: false).remove(guess);
    notificationCallback(guess.getName());
    goBack();
  }
}
