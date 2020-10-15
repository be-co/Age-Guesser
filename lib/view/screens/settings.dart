import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:age_guesser/services/storage.dart';
import 'package:age_guesser/view_model/history_list_view_model.dart';

class Settings extends StatefulWidget {
  Settings({Key key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool _historyStorageEnabled;
  String _historyStorageStateText;

  @override
  void initState() {
    super.initState();
    _historyStorageEnabled = getBoolSettings('history_storage');
    // Todo this pref should be written on first app start, quick fix to prevent error
    if (_historyStorageEnabled == null) {
      _historyStorageEnabled = true;
    }
    setHistoryStorageText(_historyStorageEnabled);
  }

  @override
  void dispose() {
    // Save settings
    saveBoolSettings('history_storage', _historyStorageEnabled);
    print("settings: saving " + _historyStorageEnabled.toString());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ListTile(
        title: Text('Guess History'),
        subtitle: Text('$_historyStorageStateText the storage of age guesses'),
        trailing: Switch(
            value: _historyStorageEnabled,
            onChanged: (value) {
              setState(() {
                setHistoryStorageText(value);
                _historyStorageEnabled = value;
              });
            }),
      ),
      Divider(),
      ListTile(
        title: Text('Delete Guess History'),
        subtitle: Text('Removes all guess history entries'),
        onTap: deleteGuessHistory,
      ),
      Divider(),
    ]);
  }

  void deleteGuessHistory() {
    Provider.of<HistoryListViewModel>(context, listen: false).removeAll();
  }

  void setHistoryStorageText(bool enabled) {
    switch (enabled) {
      case true:
        _historyStorageStateText = 'Disable';
        break;
      case false:
        _historyStorageStateText = 'Enable';
        break;
      default:
    }
  }
}
