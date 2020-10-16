import 'dart:convert';

import 'package:age_guesser/model/guess.dart';
import 'package:age_guesser/services/storage.dart';

/// Singleton class that holds a list of Guess objects
/// Used to represent the history of guesses performed by the user (as long as enabled via app settings)
class GuessHistory {
  /// Single isntance of the guess history throughout the app lifecycle
  static final GuessHistory _instance = GuessHistory._internal();

  /// List holding all guesses perfomed by the user (as long as enabled via app settings)
  List<Guess> _guessHistory;

  GuessHistory._internal() {
    _guessHistory = [];
    //print("Guess History Initialized");
  }

  factory GuessHistory() {
    return _instance;
  }

  List<Guess> getGuessHistory() {
    return _guessHistory;
  }

  void addGuess(Guess guess) {
    _guessHistory.add(guess);
  }

  void removeGuess(Guess guess) {
    _guessHistory.remove(guess);
  }

  /// Retrieves a previously stored history list from the shared preferences
  void loadFromStorage() {
    String historyJson = loadHistory();

    /// Handle null response
    if (historyJson == null) {
      //print("empty guess history json");
      /// Create empty list (first app launch)
      _guessHistory = [];
    } else {
      /// Parse String response into an actual object
      fromJson(jsonDecode(historyJson));
    }
  }

  /// Save the history list to shared preferences
  void saveToStorage() {
    /// Create JSON encoded String for storage
    String historyJson = jsonEncode(_instance);
    saveHistory(historyJson);
  }

  /// Removes all entries from the history list
  void removeAllHistoryEntries() {
    _guessHistory.clear();
  }

  /// Method used by jsonEncode to create JSON encoded string of the history list
  Map<String, dynamic> toJson() => {
        'history': _guessHistory,
      };

  /// Parses the Map provided by the jsonDecode function and adds all guess objects to the history list
  fromJson(Map<String, dynamic> json) {
    List<dynamic> historyMap = json['history'];
    List<Guess> historyList = [];
    for (int i = 0; historyMap.length > i; i++) {
      Guess tmp = Guess.fromJson(historyMap.elementAt(i));
      historyList.add(tmp);
    }
    _guessHistory = historyList;
  }
}
