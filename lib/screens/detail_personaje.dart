import 'package:dbz_app/models/personaje.dart';
import 'package:dbz_app/models/planet.dart';
import 'package:dbz_app/network/api.dart';
import 'package:dbz_app/widgets/app-bar-dbz.dart';
import 'package:dbz_app/widgets/card_planeta.dart';
import 'package:dbz_app/widgets/expanded_text.dart';
import 'package:dbz_app/widgets/saiyan_title.dart';
import 'package:flutter/material.dart';

class DetailPersonaje extends StatefulWidget {
  final int idPersonaje;

  const DetailPersonaje({super.key, required this.idPersonaje});

  @override
  State<DetailPersonaje> createState() => _DetailPersonajesState();
}

class _DetailPersonajesState extends State<DetailPersonaje> {
  late Personaje personaje;
  late Planeta? planeta;
  late List<Transformacion>? transformaciones;

  @override
  void initState() {
    super.initState();
    personaje = Personaje(
      id: 0,name: '',ki: '',maxKi: '',race: '',gender: '',description: '',image: '',affiliation: '',
      originPlanet: Planeta(id: 0, name: '', isDestroyed: false, description: '', image: ''),
      transformations: [],
    );
    planeta = Planeta(id: 0, name: '', isDestroyed: false, description: '', image: '');
    transformaciones = [];
    fetchCharacter();
  }

  void fetchCharacter() async {
    API.getCharacterById(widget.idPersonaje, (response) {
      setState(() {
        personaje = response;
        planeta = personaje.originPlanet;
        transformaciones = personaje.transformations;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double fem = MediaQuery.of(context).size.width / 375;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: const AppBarDbz(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
          child: Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: Center(
                    child: SizedBox(
                      width: double.infinity,
                      height: 490,
                      child: Image.network(
                        personaje.image.isNotEmpty
                            ? personaje.image
                            : "https://dragonball-api.com/characters/goku_normal.webp",
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  ),
                ),
                Center(
                  child: SaiyanTitle(
                    title: personaje.name,
                  ),
                ),
                const Center(
                  child: Text(
                    "Poderes",
                    style: TextStyle(
                      fontFamily: 'Bebas',
                      fontSize: 28,
                      color: Color(0xffF47A20)
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    width: 350,
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12), 
                      border: Border.all(color: Colors.grey.shade300, width: 1.5), 
                      color: Colors.white, 
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Distribuye el espacio uniformemente
                      children: [
                        _buildKiText('Ki:', personaje.ki),
                        _buildKiText('Max Ki:', personaje.maxKi),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //Titulo de la descripción
                      const Text(
                        "Información",
                        style: TextStyle(
                            fontFamily: 'Bebas',
                            fontSize: 28,
                            color: Color(0xffF47A20)),
                      ),

                      //Espacio 
                      const SizedBox(height: 9),

                      //Descripción del personaje 
                      ExpandedText(text: personaje.description),

                      //Espacio 
                      const SizedBox(height: 9),
                      const Text(
                        "Afiliación",
                        style: TextStyle(
                            fontFamily: 'Bebas',
                            fontSize: 28,
                            color: Color(0xffF47A20)),
                      ),

                      //Apartado afiliación 
                      Row(
                        children: [
                          Image.asset(
                            'assets/images/iconBall.png',
                            width: 30,
                            height: 30,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            personaje.affiliation,
                            softWrap: true,
                            textAlign: TextAlign.justify,
                            style: const TextStyle(
                              fontFamily: 'Oswald',
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),

                      //Espacio 
                      const SizedBox(height: 9),
                    ],
                  ),
                ),
                //Espacio
                const SizedBox(height: 30),

                //Card del planeta de origen 
                Center(
                  child: CardPlaneta(image: planeta!.image, name: planeta!.name, isDestroyed: planeta!.isDestroyed)
                ),
                const SizedBox(height: 60),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _buildKiText(String label, String value) {
  return RichText(
    text: TextSpan(
      text: '$label ',
      style: const TextStyle(
        color: Color(0xffF47A20),
        fontFamily: 'Bebas',
        fontSize: 22, 
      ),
      children: [
        TextSpan(
          text: value,
          style: const TextStyle(
            color: Colors.black,
            fontFamily: 'Bebas',
            fontSize: 22, 
          ),
        ),
      ],
    ),
  );
}
