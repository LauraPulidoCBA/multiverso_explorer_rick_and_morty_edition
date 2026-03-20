import 'package:flutter/material.dart';
import '../services/character_service.dart';
import '../models/character.dart';
import 'package:provider/provider.dart';
import '../provider/character_provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Character> characters = [];
  String? filter;

  @override
  void initState() {
    super.initState();
    _loadCharacters();
  }

  Future<void> _loadCharacters() async {
    final service = CharacterService();
    characters = await service.fetchCharacters(status: filter, pages: 1);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CharacterProvider>(context);

      return Scaffold(
      appBar: AppBar(title: const Text("Explorar personajes")),

body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.indigo, Colors.teal],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            DropdownButton<String>(
              value: filter,
              hint: const Text("Filtrar por estado"),
              items: const [
                DropdownMenuItem(value: "all", child: Text("Todos")),
                DropdownMenuItem(value: "alive", child: Text("Vivo")),
                DropdownMenuItem(value: "dead", child: Text("Muerto")),
                DropdownMenuItem(value: "unknown", child: Text("Desconocido")),
              ],
              onChanged: (value) {
                setState(() {
                  filter = value;
                });
                _loadCharacters();
              },
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                  childAspectRatio: 0.8,
                ),
                itemCount: characters.length,
                itemBuilder: (context, index) {
                  final character = characters[index];
                  final isFav = provider.favourites.any((c) => c.id == character.id);

                  return Card(
                    child: Column(
                      children: [
                        Expanded(
                          child: Image.network(character.image, fit: BoxFit.cover),
                        ),
                        Text(character.name),
                        Text("Estado: ${character.status}"),
                        IconButton(
                          icon: Icon(
                            isFav ? Icons.favorite : Icons.favorite_border,
                            color: Colors.red,
                          ),
                          onPressed: () => provider.toggleFavourite(character),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}



