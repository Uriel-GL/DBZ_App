import 'package:flutter/material.dart';

class CardTransformacion extends StatelessWidget {
  final String image;
  final String afiliation;

  const CardTransformacion({super.key, required this.image, required this.afiliation});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              spreadRadius: 0.5, // Ajuste para sombras más suaves
              blurRadius: 5,
              offset: Offset(2, 4),
            ),
          ],
          gradient: _radialGradient(afiliation)
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                image, //'https://dragonball-api.com/transformaciones/goku_ssj.webp',
                width: double.infinity,
                height: double.infinity,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//Regresa un gradiente dependiendo de la afiliación del personaje
RadialGradient _radialGradient(String afiliacion) {
  if(afiliacion == "Army of Frieza") {
    return const RadialGradient(
      colors: [
        Color(0xff9400d3),  
        Color(0xff4b0082),  
        Color(0xff000000),  
      ],
      stops: [0.3, 0.7, 1], 
      center: Alignment.bottomCenter,
      radius: 1.2,
    );
  } else if (afiliacion == "Freelancer") {
    return const RadialGradient(
      colors: [
        Color(0xff006400),  
        Color(0xff00a651),  
        Color(0xff72c6ef),  
        Color(0xff004e00),  
      ],
      stops: [0, 0.4, 0.7, 1],  
      center: Alignment.bottomCenter,
      radius: 1.2,  
    );
  } else {
    return const RadialGradient(
      colors: [
        Color(0xfff7941e),  
        Color(0xfff24e1e),  
        Color(0xff004e8f)   
      ],
      stops: [0.3, 0.6, 1],
      center: Alignment.bottomCenter,
      radius: 1.5,
    );
  }
}
