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
