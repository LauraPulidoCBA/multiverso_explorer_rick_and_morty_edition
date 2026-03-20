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