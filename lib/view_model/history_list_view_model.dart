import 'package:flutter/material.dart';

import 'package:age_guesser/model/guess.dart';
import 'package:age_guesser/model/guess_history.dart';
import 'package:age_guesser/services/storage.dart';

class HistoryListViewModel extends ChangeNotifier {
  final GuessHistory _history = GuessHistory();
  bool historyLoaded = false;

  HistoryListViewModel() {
    if (!historyLoaded) {
      _history.loadFromStorage();
    }
  }

  void add(Guess guess) {
    print("store? " + getBoolSettings('history_storage').toString());
    if (getBoolSettings('history_storage')) {
      _history.getGuessHistory().add(guess);
      _history.saveToStorage();
      notifyListeners();
    }
  }

  void remove(Guess guess) {
    _history.getGuessHistory().remove(guess);
    _history.saveToStorage();
    notifyListeners();
  }

  void removeAtReversed(int index) {
    _history.getGuessHistory().removeAt((listSize() - 1) - index);
    _history.saveToStorage();
    notifyListeners();
  }

  void removeAll() {
    _history.getGuessHistory().clear();
    _history.saveToStorage();
    notifyListeners();
  }

  bool isEmpty() {
    return _history.getGuessHistory().isEmpty;
  }

  Guess getGuessReversed(int index) {
    return _history.getGuessHistory().reversed.toList()[index];
  }

  int listSize() {
    return _history.getGuessHistory().length;
  }

  void refresh() {
    notifyListeners();
  }

  @override
  void dispose() {
    /// not working reliably
    _history.saveToStorage();
    super.dispose();
  }
}
