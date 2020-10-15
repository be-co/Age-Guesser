import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:age_guesser/services/webservice.dart';
import 'package:age_guesser/view/home/response_error.dart';
import 'package:age_guesser/view_model/history_list_view_model.dart';
import 'package:age_guesser/view/home/response.dart';
import 'package:age_guesser/view/home/input_form.dart';
import 'package:age_guesser/model/guess.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _responseAge;
  String _responseName;
  bool _hasResult = false;
  bool _processing = false;
  bool _responseError = false;

  @override
  void initState() {
    super.initState();
    //_historyStorageEnabled = getBoolSettings('history_storage');
    //print('storage enabled:' + _historyStorageEnabled.toString());
    print('init called home');
  }

  void getAge(String name) {
    setState(() {
      _processing = true;
    });
    fetchAge(name, setAge);
  }

  void setAge(Guess guess) {
    setState(() {
      _processing = false;
      if (guess.getAge() == null) {
        _responseError = true;
        _hasResult = false;
      } else {
        Provider.of<HistoryListViewModel>(context, listen: false).add(guess);
        _responseError = false;
        _hasResult = true;
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
          InputForm(responseCallback: getAge),
          _hasResult || _responseError
              ? Divider(
                  indent: 10.0,
                  endIndent: 10.0,
                )
              : SizedBox(),
          _processing ? CircularProgressIndicator() : SizedBox(),
          _hasResult && !_processing
              ? Response(age: _responseAge, name: _responseName)
              : SizedBox(),
          _responseError ? ResponseError() : SizedBox(),
        ],
      ),
    );
  }
}
