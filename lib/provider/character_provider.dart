class CharacterProvider extends ChangeNotifier {
  List<Character> _favourites = [];
  List<Character> get favourites => _favourites;
}
COMMIT 2
git commit -m "lógica de favoritos"

void toggleFavourite(Character character) {
  final exists = _favourites.any((c) => c.id == character.id);

  if (exists) {
    _favourites.removeWhere((c) => c.id == character.id);
  } else {
    _favourites.add(character);
  }

  notifyListeners();
}