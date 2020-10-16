import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:age_guesser/services/webservice.dart';
import 'package:age_guesser/view/home/response_error.dart';
import 'package:age_guesser/view_model/history_list.dart';
import 'package:age_guesser/view/home/response.dart';
import 'package:age_guesser/view/home/input_form.dart';
import 'package:age_guesser/model/guess.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  /// Values received from the web service to display an age guess
  int _responseAge;
  String _responseName;

  /// Variables required to show certain different UI widgets depending on the current state (error, loading, success)
  bool _hasResult = false;
  bool _processing = false;
  bool _responseError = false;

  /// Initiate web request for the name provided by the user
  void getAge(String name) {
    setState(() {
      /// Set widget state to processing, shown a loading circle
      _processing = true;
    });

    /// Web request
    fetchAge(name, setAge);
  }

  /// Function that is called by the web service after receiving a response or an error
  void setAge(Guess guess) {
    setState(() {
      _processing = false;

      /// If the response was null there was error with the name or the internet connection
      /// This will show an error widget to the user
      if (guess.getAge() == null) {
        _responseError = true;
        _hasResult = false;

        /// Successfull response
      } else {
        /// Add to the history list
        Provider.of<HistoryListViewModel>(context, listen: false).add(guess);

        /// Set widget state variables accordingly
        _responseError = false;
        _hasResult = true;

        /// Retrieve values for display
        _responseAge = guess.getAge();
        _responseName = guess.getName();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          /// Input form widget
          InputForm(responseCallback: getAge),
          _hasResult || _responseError
              ? Divider(
                  indent: 10.0,
                  endIndent: 10.0,
                )
              : SizedBox(),

          /// Loading indicator
          _processing ? CircularProgressIndicator() : SizedBox(),

          /// Response widget
          _hasResult && !_processing
              ? Response(age: _responseAge, name: _responseName)
              : SizedBox(),

          /// Error widget
          _responseError ? ResponseError() : SizedBox(),
        ],
      ),
    );
  }
}
