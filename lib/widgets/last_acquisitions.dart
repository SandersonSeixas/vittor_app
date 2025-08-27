import 'package:flutter/material.dart';
//.........................................
// Mostrar os 5 últimos livros do cadastro.
// ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
// ------------------------------------------------------------------------------------------
// Author: Sanderson
// Data  : 27/08/2025
//==============================================
class LastAcquisitions extends StatelessWidget {
  final List<dynamic> revistas;
  final void Function(int id)? onTap;

  const LastAcquisitions({super.key, required this.revistas, this.onTap});

  @override
  Widget build(BuildContext context) {
    if (revistas.isEmpty) {
      return const SizedBox(height: 160, child: Center(child: CircularProgressIndicator()));
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text("Últimas Aquisições", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        ),
        SizedBox(
          height: 160,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            itemCount: revistas.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (context, i) {
              final r = revistas[i];
              return GestureDetector(
                onTap: () => onTap?.call(r['id'] as int),
                child: SizedBox(
                  width: 110,
                  child: Column(
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(r['capa'], fit: BoxFit.cover, width: 110),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(r['titulo'], maxLines: 1, overflow: TextOverflow.ellipsis)
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
