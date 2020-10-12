import 'dart:convert';

import 'package:age_guesser/model/guess.dart';
import 'package:http/http.dart' as http;

final http.Client _client = http.Client();

Future<Guess> fetchAge(String name) async {
  /* if (_client == null) {
    _client = http.Client();
  } */
  final response = await _client.get('https://api.agify.io/?name=' + name);
  print('body' + response.body);
  return parseAgeResponse(response.body);
}

Guess parseAgeResponse(String responseBody) {
  Map<String, dynamic> tmp = jsonDecode(responseBody);
  //print(Guess.fromJson(tmp).getName());
  //print(Guess.fromJson(tmp).getAge());  
  //print(Guess.fromJson(tmp).getTimeStamp());  
  return Guess.fromJsonResponse(tmp);
}