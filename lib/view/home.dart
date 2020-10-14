import 'package:age_guesser/services/webservice.dart';
import 'package:age_guesser/view/response_error.dart';
import 'package:flutter/material.dart';

import 'package:age_guesser/view/response.dart';
import 'package:age_guesser/view/input_form.dart';
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

  void getAge(String name) {
    setState(() {
      _processing = true;
    });
    fetchAge(name, setAge);
  }

  void setAge(Guess response) {
    Guess guess = response;
    setState(() {
      _processing = false;
      if (guess.getAge() == null) {
        _responseError = true;
        _hasResult = false;
      } else {
        _responseError = false;
        _hasResult = true;
        _responseAge = guess.getAge();
        _responseName = guess.getName();
      }
    });
    //print("Age $_responseAge");
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
