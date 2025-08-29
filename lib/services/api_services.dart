// ignore_for_file: constant_identifier_names

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
//......................................
// API REST de consumo do aplicativo
// ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
// Através do PHP/MySQL conectamos ao banco na nuvem e recebemos os dados pertinentes
// da aplicação.
// -----------------------------------------------------------------------------------
// Author: Sanderson
// Date..: 27/08/2025
//===================
// Alter by: Sanderson
// on Date.: 28/08/2025
//====================
class ApiService {
  static final String baseUrl = dotenv.env['API_BASE_URL'] ?? '';

  static Future<List<dynamic>> fetchTopRevistas() async {
    final r = await http.get(Uri.parse('$baseUrl/getTopRevistas.php'));
    if (r.statusCode == 200) return jsonDecode(r.body) as List;
    throw Exception('Erro ao buscar Top Revistas');
  }

  static Future<List<dynamic>> fetchUltimasRevistas() async {
    final r = await http.get(Uri.parse('$baseUrl/getUltimasRevistas.php'));
    if (r.statusCode == 200) return jsonDecode(r.body) as List;
    throw Exception('Erro ao buscar Últimas Aquisições');
  }

  static Future<Map<String, dynamic>> login(String email, String senha) async {
    final r = await http.post(
      Uri.parse('$baseUrl/login.php'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({"email": email, "senha": senha}),
    );
    if (r.statusCode == 200) return jsonDecode(r.body) as Map<String, dynamic>;
    throw Exception('Falha no login');
  }

  static Future<bool> registrarAcesso(int id) async {
    final r = await http.get(Uri.parse('$baseUrl/registrarAcesso.php?id=$id'));
    if (r.statusCode == 200) {
      final m = jsonDecode(r.body);
      return m['success'] == true;
    }
    return false;
  }
}
