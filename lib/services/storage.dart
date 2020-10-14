import 'dart:convert';

import 'package:age_guesser/model/guess_history.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences _prefs;

void initializeSharedPrefs() async {
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

void saveHistory(GuessHistory history) {
  _prefs.setString('history', jsonEncode(history));
}

GuessHistory loadHistory() {
  String guessHistoryString = _prefs.getString('history');
  if (guessHistoryString == null || guessHistoryString == "null") {
    print("shared prefs not existing");
    return GuessHistory();
  } else {
    //print(guessHistoryString);
    GuessHistory guessHistory = GuessHistory.fromJson(jsonDecode(guessHistoryString));
    return guessHistory;
  }
}
