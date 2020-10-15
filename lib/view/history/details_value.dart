import 'package:flutter/material.dart';

class DetailsValue extends StatelessWidget {
  final String _title;
  final String _value;
  final bool _usePadding;

  DetailsValue({@required String title, @required String value, @required bool usePadding})
      : this._title = title,
        this._value = value,
        this._usePadding = usePadding;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          _title,
          style: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 18.0,
              color: Colors.white),
          textAlign: TextAlign.center,
        ),
        Padding(padding: const EdgeInsets.symmetric(vertical: 4.0)),
        Text(
          _value,
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 32.0, color: Colors.white),
          textAlign: TextAlign.center,
        ),
        _usePadding ? Padding(padding: const EdgeInsets.symmetric(vertical: 10.0)) : SizedBox(),
      ],
    );
  }
}
