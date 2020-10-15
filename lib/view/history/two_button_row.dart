import 'package:flutter/material.dart';

class TwoButtonRow extends StatelessWidget {
  final String _positiveButtonText;
  final String _negativeButtonText;
  final Function _positiveButtonCallback;
  final Function _negativeButtonCallback;

  TwoButtonRow(
      {@required String positiveButtonText,
      @required String negativeButtonText,
      @required Function positiveButtonCallback,
      @required Function negativeButtonCallback})
      : this._positiveButtonText = positiveButtonText,
        this._negativeButtonText = negativeButtonText,
        this._positiveButtonCallback = positiveButtonCallback,
        this._negativeButtonCallback = negativeButtonCallback;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(padding: EdgeInsets.symmetric(horizontal: 5.0)),
        Expanded(
          child: RaisedButton(
            child: Text(_positiveButtonText),
            onPressed: () {
              _positiveButtonCallback();
            },
          ),
        ),
        Padding(padding: EdgeInsets.symmetric(horizontal: 2.0)),
        Expanded(
          child: RaisedButton(
            color: Colors.red,
            child: Text(_negativeButtonText),
            onPressed: () {
              _negativeButtonCallback();
            },
          ),
        ),
        Padding(padding: EdgeInsets.symmetric(horizontal: 5.0)),
      ],
    );
  }
}
