import 'package:age_guesser/model/guess.dart';

class GuessViewModel {
  final Guess guess;

  GuessViewModel({this.guess});

  String get name {
    return this.guess.getName();
  }

  int get age {
    return this.guess.getAge();
  }

  DateTime get timestamp {
    return this.guess.getTimeStamp();
  }
}