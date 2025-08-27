import 'dart:convert';
import 'package:http/http.dart' as http;
//......................................
// API REST de consumo do aplicativo
// ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
// Através do PHP/MySQL conectamos ao banco na nuvem e recebemos os dados pertinentes
// da aplicação.
// -----------------------------------------------------------------------------------
// Author: Sanderson
// Date..: 27/08/2025
//===================
// Alter by:
// on Date.:
//====================
class ApiService {
  static const String BASE_URL = 'https://samsxs.net.br/flutter/vittor/api';

  static Future<List<dynamic>> fetchTopRevistas() async {
    final r = await http.get(Uri.parse('$BASE_URL/getTopRevistas.php'));
    if (r.statusCode == 200) return jsonDecode(r.body) as List;
    throw Exception('Erro ao buscar Top Revistas');
    }

  static Future<List<dynamic>> fetchUltimasRevistas() async {
    final r = await http.get(Uri.parse('$BASE_URL/getUltimasRevistas.php'));
    if (r.statusCode == 200) return jsonDecode(r.body) as List;
    throw Exception('Erro ao buscar Últimas Aquisições');
  }

  static Future<Map<String,dynamic>> login(String email, String senha) async {
    final r = await http.post(
      Uri.parse('$BASE_URL/login.php'),
      headers: {'Content-Type':'application/json'},
      body: jsonEncode({"email": email, "senha": senha}),
    );
    if (r.statusCode == 200) return jsonDecode(r.body) as Map<String,dynamic>;
    throw Exception('Falha no login');
  }

  static Future<bool> registrarAcesso(int id) async {
    final r = await http.get(Uri.parse('$BASE_URL/registrarAcesso.php?id=$id'));
    if (r.statusCode == 200) {
      final m = jsonDecode(r.body);
      return m['success'] == true;
    }
    return false;
  }
}
