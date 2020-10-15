



import 'package:age_guesser/model/guess.dart';
import 'package:flutter/material.dart';

class HistoryListViewModel extends ChangeNotifier {
  final List<Guess> _history = [];

  void add(Guess guess) {
    _history.add(guess);
    notifyListeners();
  }

  void removeAll() {
    _history.clear();
    notifyListeners();
  }
}