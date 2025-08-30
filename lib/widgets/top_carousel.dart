import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
//....................................................
// Carrossel dos 3 livros mais acessados
// ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
// Uso de um SLIDER em formato de carrossel para fazer a rolagem dos 3 livros mais acessados
// ------------------------------------------------------------------------------------------
// Author: Sanderson
// Data  : 27/08/2025
//=========================================
class TopCarousel extends StatelessWidget {
  final List<dynamic> revistas;
  final void Function(int id)? onTap;

  const TopCarousel({super.key, required this.revistas, this.onTap});

  @override
  Widget build(BuildContext context) {
    if (revistas.isEmpty) {
      return const SizedBox(height: 220, child: Center(child: CircularProgressIndicator()));
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text("Mais Acessados", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        ),
        CarouselSlider(
          options: CarouselOptions(
            height: 220,
            autoPlay: true,
            enlargeCenterPage: true,
            viewportFraction: 0.7,
          ),
          items: revistas.map((r) {
            return GestureDetector(
              onTap: () => onTap?.call(r['id'] as int),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(r['capa'], fit: BoxFit.cover, alignment: Alignment.topCenter),
                    Positioned(
                      left: 0, right: 0, bottom: 0,
                      child: Container(
                        height: 200,
                        padding: const EdgeInsets.all(8),
                        color: Colors.black54,
                        child: Text(r['titulo'], maxLines: 1, overflow: TextOverflow.ellipsis,
                          style: const TextStyle(color: Colors.white)),
                      ),
                    )
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
