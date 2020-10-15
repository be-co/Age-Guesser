import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  Settings({Key key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool enabled;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8, bottom: 8),
      child: Row(
        children: [
          Expanded(
            child: Text(
              'Test',
              style: TextStyle(fontSize: 22),
            ),
          ),
          Switch(
              value: enabled,
              onChanged: (switched) {
                setState(() {
                  enabled = switched;
                });
              })
        ],
      ),
    );
  }

  Widget _tmp() {
    final styleEnabled = TextStyle(
      color: Theme.of(context).colorScheme.primary,
      fontWeight: FontWeight.bold,
    );
    final styleDisabled = TextStyle(
      color: Colors.black38,
      fontWeight: FontWeight.bold,
    );
  }
}
