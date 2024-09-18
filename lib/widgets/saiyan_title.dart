import 'package:flutter/material.dart';

/// componente que regresa un titulo personalizado con la tipografia de DragonBall
class SaiyanTitle extends StatelessWidget {
  final String title;

  const SaiyanTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          Text(
            title,
            style: TextStyle(
              fontFamily: "Saiyan",
              fontSize: 44,
              foreground: Paint()
                ..style =
                    PaintingStyle.stroke 
                ..strokeWidth = 1 
                ..color = Colors.black,
            ),
          ),
          // Texto de relleno
          Text(
            title,
            style: const TextStyle(
              color: Color(0xfff0df2f), 
              fontFamily: "Saiyan",
              fontSize: 44,
            ),
          ),
        ],
      ),
    );
  }
}