import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/character_provider.dart';

class FavouritesScreen extends StatelessWidget {
  const FavouritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CharacterProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Mis Favoritos")),
      body: provider.favourites.isEmpty
          ? const Center(child: Text("No tienes favoritos aún"))
          : GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                childAspectRatio: 0.8,
              ),
              itemCount: provider.favourites.length,
              itemBuilder: (context, index) {
                final fav = provider.favourites[index];

                return Card(
                  child: Column(
                    children: [
                      Expanded(
                        child: Image.network(fav.image, fit: BoxFit.cover),
                      ),
                      Text(fav.name),
                      Text("Estado: ${fav.status}"),
                    ],
                  ),
                );
              },
            ),
    );
  }
}