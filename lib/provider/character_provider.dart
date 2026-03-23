
class CharacterProvider extends ChangeNotifier {
  List<Character> _favourites = [];
  List<Character> get favourites => _favourites;
}
void toggleFavourite(Character character) {
  final exists = _favourites.any((c) => c.id == character.id);

  if (exists) {
    _favourites.removeWhere((c) => c.id == character.id);
  } else {
    _favourites.add(character);
  }

  notifyListeners();
}

Future<void> _saveToDisk() async {
  final prefs = await SharedPreferences.getInstance();
  final data = json.encode(_favourites.map((c) => c.toMap()).toList());
  await prefs.setString('favourites', data);
}
Future<void> _loadFromDisk() async {
  final prefs = await SharedPreferences.getInstance();
  final data = prefs.getString('favourites');

  if (data != null) {
    final decoded = json.decode(data) as List;
    _favourites = decoded.map((m) => Character.fromMap(m)).toList();
    notifyListeners();
  }
}
import 'package:flutter/material.dart';

class CharacterProvider extends ChangeNotifier {}

