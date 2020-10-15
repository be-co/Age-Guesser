import 'dart:convert';

import 'package:age_guesser/model/guess.dart';
import 'package:age_guesser/services/storage.dart';

class GuessHistory {
  static final GuessHistory _instance = GuessHistory._internal();

  List<Guess> _guessHistory;

  GuessHistory._internal() {
    _guessHistory = [];
    print("Guess History Initialized");
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

  void loadFromStorage() {
    String historyJson = loadHistory();
    if (historyJson == null) {
      print("empty guess history json");
      _guessHistory = [];
    }
    fromJson(jsonDecode(historyJson));
  }

  void saveToStorage() {
    String historyJson = jsonEncode(_instance);
    saveHistory(historyJson);
  }

  void removeAllHistoryEntries() {
    _guessHistory.clear();
  }

  Map<String, dynamic> toJson() => {
    'history' : _guessHistory, 
  };

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