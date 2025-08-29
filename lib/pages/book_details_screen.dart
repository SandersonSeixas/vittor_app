import 'package:flutter/material.dart';

class BookDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> livro;

  const BookDetailsScreen({super.key, required this.livro});

  @override
  Widget build(BuildContext context) {
    final titulo = livro['titulo'] ?? 'Título Desconhecido';
    final capa = livro['capa'] ?? ''; 
    final descricao = livro['descricao'] ?? 'Sem descrição disponível.';
    final arquivo = livro['arquivo'] ?? '';

    return Scaffold(
      appBar: AppBar(
        title: Text(titulo),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (capa.isNotEmpty)
              Center(
                child: Image.network(
                  capa,
                  height: 200,
                  fit: BoxFit.contain,
                  errorBuilder: (_, __, ___) => const Icon(Icons.image_not_supported),
                ),
              ),
            const SizedBox(height: 16),
            Text(
              titulo,
              style: Theme.of(context).textTheme.headline6,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  descricao,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                // TODO: abrir com url_launcher ou WebView
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Abrindo PDF: $arquivo')),
                );
              },
              icon: const Icon(Icons.picture_as_pdf),
              label: const Text('Abrir PDF'),
            ),
          ],
        ),
      ),
    );
  }
}
