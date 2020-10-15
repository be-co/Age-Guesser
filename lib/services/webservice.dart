import 'dart:convert';

import 'package:age_guesser/model/guess.dart';
import 'package:http/http.dart' as http;

final http.Client _client = http.Client();

void fetchAge(String name, Function callback) async {
  final response = await _client.get('https://api.agify.io/?name=' + name);
  //print('body' + response.body);
  Guess parsedResponse = _parseAgeResponse(response.body);
  callback(parsedResponse);
}

Guess _parseAgeResponse(String responseBody) {
  Map<String, dynamic> tmp = jsonDecode(responseBody);
  return Guess.fromJsonResponse(tmp);
}