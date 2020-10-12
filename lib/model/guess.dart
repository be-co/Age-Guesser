import 'package:flutter/cupertino.dart';

class Guess {
  final String _name;
  final int _age;
  final DateTime _timestamp;

  Guess({@required String name, int age, DateTime timestamp}) : 
    this._name = name, 
    this._age = age,  
    this._timestamp = timestamp ?? new DateTime.now();

/*
  static DateTime setDate(String timestamp) {
    if (timestamp != null) {
      return DateTime.parse(timestamp);
    } else {
      return new DateTime.now();
    }
  } */

  String getName() {
    return this._name;
  }

  int getAge() {
    return this._age;
  }

  DateTime getTimeStamp() {
    return this._timestamp;
  }
 /*
  setAge(int age) {
    this._age = age;
  } */

  // Handle response from API
  factory Guess.fromJsonResponse(Map<String, dynamic> json) {
    return Guess(
        name: json['name'] as String,
        age: json['age'] as int,
      );
  }

  // Handle data loaded from shared prefs
  factory Guess.fromJson(Map<String, dynamic> json) {
    return Guess(
      name: json['name'] as String,
      age: json['age'] as int,
      timestamp: DateTime.parse(json['ts']),
    );
  }

  Map<String, dynamic> toJson() => {
    'name' : _name,
    'age' : _age,
    'ts' : _timestamp.toIso8601String(),
  };
}