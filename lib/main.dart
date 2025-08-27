import 'package:flutter/material.dart';
import 'home/home.view.dart';
//....................................................
// Main
// ^^^^^
// Arquivo de root de inicialização da aplicação
// ----------------------------------------------------------------------
// Author: Sanderson
// Data  : 27/08/2025
//=========================================

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vittor`s Library',
      theme: ThemeData(
        // This is the theme of your application.
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
