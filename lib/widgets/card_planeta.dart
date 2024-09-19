import 'package:flutter/material.dart';

class CardPlaneta extends StatelessWidget {
  final String image;
  final String name;
  final bool isDestroyed;
  final bool isDetail;

  const CardPlaneta({super.key, required this.image, required this.name, required this.isDestroyed, this.isDetail = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      height: 200,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            spreadRadius: 1,
            blurRadius: 10,
            offset: Offset(2, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                isDetail == true ? "Planeta de Origen" : "Información del Planeta",
                style: const TextStyle(
                  fontFamily: 'Bebas',
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xffF47A20),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    image.isNotEmpty ? image : 'https://dragonball-api.com/planetas/Planeta_Vegeta_en_Dragon_Ball_Super_Broly.webp',
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          fontFamily: 'Oswald',
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        "Estatus:",
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Bebas',
                          color: Colors.black54,
                        ),
                      ),
                      Text(
                        isDestroyed
                            ? "Planeta Destruido"
                            : "Planeta aún intacto",
                        style: const TextStyle(
                          fontSize: 18,
                          fontFamily: 'Bebas',
                          color: Color(0xffF47A20),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
