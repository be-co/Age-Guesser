import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:age_guesser/services/storage.dart';
import 'package:age_guesser/view_model/history_list.dart';

class Settings extends StatefulWidget {
  Settings({Key key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  /// Value for the 'Guess History' setting
  bool _historyStorageEnabled;

  /// Text for the 'Guess History' subtitle
  String _historyStorageStateText;

  @override
  void initState() {
    super.initState();
    _historyStorageEnabled = getBoolSettings('history_storage');
    // TODO this pref should be written on first app start, quick fix to prevent null error
    if (_historyStorageEnabled == null) {
      _historyStorageEnabled = true;
    }

    /// Set the subtitle of the 'Guess History' setting according to the stored value
    setHistoryStorageText(_historyStorageEnabled);
  }

  @override
  void dispose() {
    // Save settings when the widget is disposed/the app is closed
    saveBoolSettings('history_storage', _historyStorageEnabled);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      /// 'Guess History'
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

      /// 'Delete Guess History'
      ListTile(
        title: Text('Delete Guess History'),
        subtitle: Text('Removes all guess history entries'),
        onTap: deleteGuessHistory,
      ),
      Divider(),
    ]);
  }

  /// Removes all entries from the history list
  void deleteGuessHistory() {
    Provider.of<HistoryListViewModel>(context, listen: false).removeAll();
  }

  /// Function that returns the corresponding text value for the currently used 'Guess History' setting
  /// true -> 'Disable'
  /// false -> 'Enable'
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
