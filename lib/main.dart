import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import './pages/splash_screen.dart';
//....................................................
// Main / BRANCH PARA OS DEMAIS ALUNOS, INCLUSIVE VOCÊ
// ^^^^^
// Arquivo de root de inicialização da aplicação
// ----------------------------------------------------------------------
// Author: Sanderson
// Data  : 27/08/2025
//=========================================

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env"); // Carrega as variáveis de ambiente
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
        primarySwatch: Colors.purple,
      ),
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
