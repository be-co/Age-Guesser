import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences _prefs;

/// Initialize shared prefs once
Future initializeSharedPrefs() async {
  if (_prefs == null) {
    _prefs = await SharedPreferences.getInstance();
    //print("SharedPrefs initialized");
  } else {
    //print("SharedPrefs already initialized");
  }
}

/// Saves a boolean value using the provided key
void saveBoolSettings(String key, bool value) {
  _prefs.setBool(key, value);
}

/// Retrieves a boolean value for the provided key
/// Returns null when there is no value for the provided key
bool getBoolSettings(String key) {
  bool value = _prefs.getBool(key);
  return value;
}

/// Saves a String value using the provided key
void saveStringSettings(String key, String value) {
  _prefs.setString(key, value);
}

/// Retrieves a string value for the provided key
/// Returns null when there is no value for the provided key
String getStringSettings(String key) {
  String value = _prefs.getString(key);
  return value;
}

/// Saves an int value using the provided key
void saveIntSettings(String key, int value) {
  _prefs.setInt(key, value);
}

/// Retrieves an int value for the provided key
/// Returns null when there is no value for the provided key
int getIntSettings(String key) {
  int value = _prefs.getInt(key);
  return value;
}

/// Saves the JSON formatted String representing the history list to shared preferences
void saveHistory(String historyJson) {
  _prefs.setString('history', historyJson);
}

/// Load previously stored history list from shared preferences
String loadHistory() {
  String guessHistoryString = _prefs.getString('history');

  /// Handle null value response (first app launch)
  if (guessHistoryString == null || guessHistoryString == "null") {
    print("shared prefs not existing");
    return null;
  } else {
    return guessHistoryString;
  }
}
