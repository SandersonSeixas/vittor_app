import 'package:flutter/material.dart';
import '../services/api_services.dart';
import '../widgets/top_carousel.dart';
import '../widgets/last_acquisitions.dart';
//....................................................
// LandPage do aplicativo
// ^^^^^^^^^^^^^^^^^^^^^^
// Ao abrir o aplicativo será mostrado uma tela contendo as capas dos 3 livros mais acessados
// seguido dos 5 últimos cadastrados.
// ------------------------------------------------------------------------------------------
// Author: Sanderson
// Data  : 27/08/2025
//=========================================
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic> top = [];
  List<dynamic> ultimas = [];
  bool loading = true;
  String? error;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    try {
      final t = await ApiService.fetchTopRevistas();
      final u = await ApiService.fetchUltimasRevistas();
      setState(() {
        top = t;
        ultimas = u;
        loading = false;
      });
    } catch (e) {
      setState(() {
        loading = false;
        error = e.toString();
      });
    }
  }

  void _abrirLogin() {
    showDialog(context: context, builder: (_) => const _LoginDialog());
  }

  Future<void> _abrirRevista(int id) async {
    // registra acesso e depois abre URL do PDF (poderia navegar para uma tela de leitura)
    await ApiService.registrarAcesso(id);
    final revista = [
      ...top,
      ...ultimas,
    ].firstWhere((r) => r['id'] == id, orElse: () => null);
    if (revista != null && mounted) {
      final url = revista['arquivo'] as String;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Abrindo: $url')));
      // TODO: abir em WebView / url_launcher
    }
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    if (error != null) {
      return Scaffold(
        appBar: AppBar(title: const Text("Vittor`s Library")),
        body: Center(child: Text('Erro: $error')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Biblioteca Digital"),
        centerTitle: true,
        actions: [
          TextButton.icon(
            onPressed: _abrirLogin,
            icon: const Icon(Icons.login, color: Colors.white),
            label: const Text('Login', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _load,
        child: ListView(
          children: [
            TopCarousel(revistas: top, onTap: _abrirRevista),
            const SizedBox(height: 12),
            LastAcquisitions(revistas: ultimas, onTap: _abrirRevista),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

class _LoginDialog extends StatefulWidget {
  const _LoginDialog();

  @override
  State<_LoginDialog> createState() => _LoginDialogState();
}

class _LoginDialogState extends State<_LoginDialog> {
  final emailCtrl = TextEditingController();
  final senhaCtrl = TextEditingController();
  String perfil = 'leitor';
  bool loading = false;
  String? error;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Entrar'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: emailCtrl,
            decoration: const InputDecoration(labelText: 'E-mail'),
          ),
          TextField(
            controller: senhaCtrl,
            decoration: const InputDecoration(labelText: 'Senha'),
            obscureText: true,
          ),
          const SizedBox(height: 8),
          DropdownButtonFormField<String>(
            value: perfil,
            items: const [
              DropdownMenuItem(value: 'admin', child: Text('Admin')),
              DropdownMenuItem(value: 'editor', child: Text('Editor')),
              DropdownMenuItem(value: 'leitor', child: Text('Leitor')),
            ],
            onChanged: (v) => setState(() => perfil = v!),
            decoration: const InputDecoration(labelText: 'Perfil'),
          ),
          if (error != null)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(error!, style: const TextStyle(color: Colors.red)),
            ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancelar'),
        ),
        ElevatedButton(
          onPressed: loading
              ? null
              : () async {
                  setState(() {
                    loading = true;
                    error = null;
                  });
                  try {
                    final r = await ApiService.login(
                      emailCtrl.text.trim(),
                      senhaCtrl.text,
                    );
                    if (r['success'] == true) {
                      // validar perfil.. se quiser: if (r['usuario']['perfil'] != perfil) ...
                      if (mounted) {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Bem-vindo(a), ${r['usuario']['nome']} (${r['usuario']['perfil']})',
                            ),
                          ),
                        );
                        // TODO: navegar para a tela específica do perfil...
                      }
                    } else {
                      setState(() {
                        error = r['message'] ?? 'Falha no login';
                      });
                    }
                  } catch (e) {
                    setState(() {
                      error = e.toString();
                    });
                  } finally {
                    if (mounted) {}
                    setState(() {
                      loading = false;
                    });
                  }
                },
          child: loading
              ? const SizedBox(
                  height: 16,
                  width: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text('Entrar'),
        ),
      ],
    );
  }
}
