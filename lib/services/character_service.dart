import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/character.dart';

class CharacterService {
  Future<List<Character>> fetchCharacters({String? status, int pages = 1}) async {
    List<Character> allCharacters = [];

    for (int i = 1; i <= pages; i++) {
      String urlString = "https://rickandmortyapi.com/api/character?page=$i";
      if (status != null && status != "all") {
        urlString += "&status=$status";
      }
      var url = Uri.parse(urlString);
      var response = await http.get(url);

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        List results = data["results"];
      }
    }

    return allCharacters;
  }
}