import 'package:dbz_app/models/personaje.dart';
import 'package:dbz_app/network/api.dart';
import 'package:dbz_app/screens/detail_personaje.dart';
import 'package:flutter/material.dart';

class CardPersonaje extends StatefulWidget {
  final int id;
  final String name;
  final String imageUrl;
  final Personaje model;

  const CardPersonaje({
    super.key, 
    required this.id, 
    required this.name, 
    required this.imageUrl, 
    required this.model
  });

  @override
  State<CardPersonaje> createState() => _CardPersonajeState();
}

class _CardPersonajeState extends State<CardPersonaje> {

  Future<void> _navigateDetail(BuildContext context) async {
    showDialog(
      context: context, 
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
    );

    API.getCharacterById(widget.id, (data) {
      var model = data;

      Navigator.pop(context);

      Navigator.push(context, 
        MaterialPageRoute(builder: (context) => DetailPersonaje(idPersonaje: widget.id, model: model))
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        debugPrint("Se presiono ${widget.name}");
        _navigateDetail(context);
      },
      child: Container(
        width: 160,
        height: 200,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              blurRadius: 5,
              offset: const Offset(0, -2), 
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Image.network(
                widget.imageUrl
              ),
              Container(
                //padding: const EdgeInsets.symmetric(vertical: 2, horizontal:50),
                width: double.infinity,
                height: 25,
                color: Colors.black
                    .withOpacity(0.7),
                child: Center(
                  child: Text(
                    widget.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
