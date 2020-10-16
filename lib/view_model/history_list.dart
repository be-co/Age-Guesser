import 'package:flutter/material.dart';

import 'package:age_guesser/model/guess.dart';
import 'package:age_guesser/model/guess_history.dart';
import 'package:age_guesser/services/storage.dart';

/// View model for the history list screen
/// Implemented as a provider, will notify all subscriber when the content changes
class HistoryListViewModel extends ChangeNotifier {
  final GuessHistory _history = GuessHistory();
  bool historyLoaded = false;

  HistoryListViewModel() {
    /// Prevent the history to be loaded multiple times from storage
    /// In case the constructor should be called more than once by flutter
    if (!historyLoaded) {
      _history.loadFromStorage();
    }
  }

  /// Add a guess to the history list
  void add(Guess guess) {
    // Only add the guess to the history list when the history is actually enabled
    /// Otherwise don't do anything
    if (getBoolSettings('history_storage')) {
      _history.getGuessHistory().add(guess);
      _history.saveToStorage();
      notifyListeners();
    }
  }

  /// Remove a guess from the history list
  void remove(Guess guess) {
    _history.getGuessHistory().remove(guess);
    _history.saveToStorage();
    notifyListeners();
  }

  /// Remove a guess from the history list by specifying it's index
  /// Since the view gets a reversed list, we need to trick a bit to not remove the item at the wrong index
  void removeAtReversed(int index) {
    _history.getGuessHistory().removeAt((listSize() - 1) - index);
    _history.saveToStorage();
    notifyListeners();
  }

  /// Remove all entries from the history list
  void removeAll() {
    _history.getGuessHistory().clear();
    _history.saveToStorage();
    notifyListeners();
  }

  bool isEmpty() {
    return _history.getGuessHistory().isEmpty;
  }

  /// Returns a guess from the history list specified by the index
  /// As already mentioned before, since the view should get a reversed list (to show new entries first)
  /// We create a reversed list and return the corresponding guess from this new list
  /// TODO this is not really ideal and could lead to performance problems with bigger lists
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
