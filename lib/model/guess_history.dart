import 'package:age_guesser/model/guess.dart';

class GuessHistory {
  List<Guess> _guessHistory;

  GuessHistory({List<Guess> guessHistory}) {
    this._guessHistory = guessHistory ?? [];
  }

  void addGuess(Guess guess) {
    this._guessHistory.add(guess);
  }

  List<Guess> getGuessHistory() {
    return _guessHistory;
  }

  Map<String, dynamic> toJson() => {
    'history' : _guessHistory, 
  };

  factory GuessHistory.fromJson(Map<String, dynamic> json) {
    List<dynamic> historyMap = json['history'];
    List<Guess> history = [];
    for (int i = 0; historyMap.length > i; i++) {
      Guess tmp = Guess.fromJson(historyMap.elementAt(i));
      history.add(tmp);
      print(tmp.getName());
    }
    
    //historyMap.map((elem) => jsonDecode(elem));
    //fetchAge('bernd');

    //print("runtime:" + historyMap.runtimeType.toString());
    //history = (List<Guess>) historyMap;
    //print('fromJSON1');
    //print(historyMap is List<Guess>);
    print(json);
    //print(history.length);
    /*return GuessHistory(
      guessHistory : json['history'],
    ); */
    return GuessHistory(
      guessHistory : history,
    );
  }
}