import 'package:flutter/cupertino.dart';

/// Class that holds all values associated with an age guess
class Guess {
  final String _name;
  final int _age;
  final DateTime _timestamp;

  Guess({@required String name, int age, DateTime timestamp})
      : this._name = name,
        this._age = age,
        // When created by receiving a guess from the API use a current timestamp, otherwise use the passed one
        this._timestamp = timestamp ?? new DateTime.now();

  String getName() {
    return this._name;
  }

  int getAge() {
    return this._age;
  }

  DateTime getTimeStamp() {
    return this._timestamp;
  }

  /// Create a Guess object from a JSON decoded String, which is a Map containing the key and value pairs
  /// Used when creating a Guess object that was locally saved using Shared Preferences
  factory Guess.fromJson(Map<String, dynamic> json) {
    return Guess(
      name: json['name'] as String,
      age: json['age'] as int,
      timestamp: DateTime.parse(json['ts']),
    );
  }

  /// Same as the Guess.fromJson method but omitting the timestamp, used to handle responses from the web API
  factory Guess.fromJsonResponse(Map<String, dynamic> json) {
    return Guess(
      name: json['name'] as String,
      age: json['age'] as int,
    );
  }

  /// Method that creates a JSON String of the guess objects, used by jsonEncode()
  Map<String, dynamic> toJson() => {
        'name': _name,
        'age': _age,

        /// We have to convert the complex object DateTime to a String to allow the creation of a JSON String
        'ts': _timestamp.toIso8601String(),
      };

  /// Returns a string representation of the time that has passed since the guess object's timestamp has been created
  /// In Minutes when <60 Minutes, in hours when <24 hours, otherwise in days
  String getTimePassed() {
    /// Get current timestamp and calculate difference
    DateTime now = DateTime.now();
    final diffHours = now.difference(getTimeStamp()).inHours;
    final diffMinutes = now.difference(getTimeStamp()).inMinutes;

    if (diffHours == 0) {
      if (diffMinutes < 1) {
        return "<1 minute ago";
      } else if (diffMinutes == 1) {
        return "1 minute ago";
      }
      return diffMinutes.toString() + " minutes ago";
    } else if (diffHours < 24) {
      if (diffHours == 1) {
        return "1 hour ago";
      }
      return diffHours.toString() + " hours ago";
    } else {
      int days = diffHours ~/ 24;
      return days.toString() + " days ago";
    }
  }
}
