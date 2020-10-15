import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences _prefs;

Future initializeSharedPrefs() async {
  if (_prefs == null) {
    _prefs = await SharedPreferences.getInstance();
    print("SharedPrefs initialized");
  } else {
    print("SharedPrefs already initialized");
  }
}

void saveStringSettings(String key, String value) {
  _prefs.setString(key, value);
}

String getStringSettings(String key) {
  String value = _prefs.getString(key);
  return value;
}

void saveIntSettings(String key, int value) {
  _prefs.setInt(key, value);
}

int getIntSettings(String key) {
  int value = _prefs.getInt(key);
  return value;
}

void saveHistory(String historyJson) {
  _prefs.setString('history', historyJson);
}

String loadHistory() {
  String guessHistoryString = _prefs.getString('history');
  if (guessHistoryString == null || guessHistoryString == "null") {
    print("shared prefs not existing");
    return null;
  } else {
    return guessHistoryString;
  }
}
