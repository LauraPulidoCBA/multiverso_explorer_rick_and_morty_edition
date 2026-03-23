import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'provider/character_provider.dart';
import 'screens/main_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CharacterProvider()),
      ],
      child: const MultiversoApp(),
    ),
  );
}

class MultiversoApp extends StatelessWidget {
  const MultiversoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Multiverso Explorer',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.deepPurple,
        scaffoldBackgroundColor: Colors.black87,
        useMaterial3: true,
      ),
      home: const MainScreen(),
    );
  }
}