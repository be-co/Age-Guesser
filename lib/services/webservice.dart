import 'dart:convert';

import 'package:age_guesser/model/guess.dart';
import 'package:http/http.dart' as http;

/// Initialize http client once on app startup
final http.Client _client = http.Client();

/// Fetches the guessed age from the API for the provided name
/// Will call the callback function after receiving a response
void fetchAge(String name, Function callback) async {
  final response = await _client.get('https://api.agify.io/?name=' + name);
  //print('body' + response.body);
  Guess parsedResponse = _parseAgeResponse(response.body);
  callback(parsedResponse);
}

/// Parses the JSON response from the web API and creates an Guess object from it
Guess _parseAgeResponse(String responseBody) {
  Map<String, dynamic> tmp = jsonDecode(responseBody);
  return Guess.fromJsonResponse(tmp);
}
