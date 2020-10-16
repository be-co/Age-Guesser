import 'package:flutter/material.dart';

/// Widget that creates a row with two button
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

        /// Positive Button
        Expanded(
          child: RaisedButton(
            /// Name
            child: Text(_positiveButtonText),

            /// Callback when pressed
            onPressed: () {
              _positiveButtonCallback();
            },
          ),
        ),
        Padding(padding: EdgeInsets.symmetric(horizontal: 2.0)),

        /// Negative Button
        Expanded(
          child: RaisedButton(
            color: Colors.red,

            /// Name
            child: Text(_negativeButtonText),

            /// Callback when pressed
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
