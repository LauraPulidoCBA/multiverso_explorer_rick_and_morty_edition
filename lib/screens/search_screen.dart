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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownButton<String>(
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
                    margin: const EdgeInsets.all(6),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 3,
                    child: Column(
                      children: [
                        Expanded( 
                          child: ClipRRect(
                            borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
                            child: Image.network(
                              character.image,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                          child: Column(
                            children: [
                              Text(
                                character.name,
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                "Estado: ${character.status}",
                                style: const TextStyle(fontSize: 11, color: Colors.grey),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            isFav ? Icons.favorite : Icons.favorite_border,
                            color: Colors.red,
                            size: 18,
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