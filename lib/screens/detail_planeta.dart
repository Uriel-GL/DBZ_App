import 'package:dbz_app/models/personaje.dart';
import 'package:dbz_app/models/planet.dart';
import 'package:dbz_app/widgets/app-bar-dbz.dart';
import 'package:dbz_app/widgets/card_personaje.dart';
import 'package:dbz_app/widgets/expanded_text.dart';
import 'package:dbz_app/widgets/saiyan_title.dart';
import 'package:flutter/material.dart';

class DetailPlaneta extends StatefulWidget {
  final Planeta model;

  const DetailPlaneta({super.key, required this.model});

  @override
  State<DetailPlaneta> createState() => _DetailPlanetaState();
}

class _DetailPlanetaState extends State<DetailPlaneta> {
  List<Personaje> _habitantes = [];

  @override
  void initState() {
    super.initState();
    _habitantes = widget.model.characters ?? [];
    debugPrint("Habitantes: ${_habitantes.length}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarDbz(),
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30))),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  //Imagen del planeta
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        widget.model.image,
                        width: 150,
                        height: 150,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  //Nombre del planeta
                  SaiyanTitle(title: widget.model.name),

                  //Titulo de la descripción
                  const Text(
                    "Información del Planeta",
                    style: TextStyle(
                        fontFamily: 'Bebas',
                        fontSize: 28,
                        color: Color(0xffF47A20)),
                  ),

                  //Descripción del planeta
                  ExpandedText(text: widget.model.description),

                  //Espacio
                  const SizedBox(height: 20),

                  //Titulo de los habitantes
                  Text(
                    "Personajes del planeta ${widget.model.name}",
                    style: const TextStyle(
                        fontFamily: 'Bebas',
                        fontSize: 28,
                        color: Color(0xffF47A20)),
                  ),

                  //Espacio
                  const SizedBox(height: 10),

                  // Lista de los habitantes
                  _habitantes.isNotEmpty
                      ? SizedBox(
                          //height: 400,
                          child: GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 20,
                              crossAxisSpacing: 15,
                            ),
                            itemCount: _habitantes.length,
                            itemBuilder: (context, index) {
                              return CardPersonaje(
                                  id: _habitantes[index].id,
                                  name: _habitantes[index].name,
                                  imageUrl: _habitantes[index].image,
                                  model: _habitantes[index]);
                            },
                          ),
                        )
                      : const Text(
                          "Este planeta no tiene habitantes registrados por ahora.",
                          style: TextStyle(
                            fontFamily: 'Oswald',
                            fontSize: 20,
                          ),
                          textAlign: TextAlign.justify,
                        ),

                  // Espacio para cubrir el espacio cuando no hay personajes. 
                  _habitantes.isNotEmpty
                  ? const SizedBox(height: 0)
                  : const SizedBox(height: 300),

                  //Espacio
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
