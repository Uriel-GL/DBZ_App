import 'package:dbz_app/models/personaje.dart';
import 'package:dbz_app/network/api.dart';
import 'package:dbz_app/widgets/app-bar-dbz.dart';
import 'package:dbz_app/widgets/card_personaje.dart';
import 'package:dbz_app/widgets/drawer_dbz.dart';
import 'package:dbz_app/widgets/saiyan_title.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Personaje> personajes = [];
  int currentPage = 0;
  int totalPages = 0;
  int totalPersonajes = 0;
  int personajesInPage = 0;

  @override
  void initState() {
    super.initState();
    // Ejecuta después de que el widget se ha construido completamente.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchPersonajes(context);
    });
  }

  Future<void> _fetchPersonajes(BuildContext context) async {
    //Se incia el loader
    showDialog(
      context: context, 
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Center(
          child: CircularProgressIndicator(
            color: Color(0xffF47A20),
          ),
        );
      }
    );

    API.getAllCharacters((response) {
      Navigator.pop(context);

      setState(() {
        personajes = response.items;
        currentPage = response.meta.currentPage; //Valor inicial
        totalPages = response.meta.totalPages; 
        personajesInPage = response.items.length;
        totalPersonajes = response.meta.totalItems;
        debugPrint("Personajes: ${personajes.length}");
        debugPrint("Paginas: $totalPages");
      });
    });
  }

  Future<void> _fetchNextPage(BuildContext context, int page) async {
    //Se incia el loader
    showDialog(
      context: context, 
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Center(
          child: CircularProgressIndicator(
            color: Color(0xffF47A20),
          ),
        );
      }
    );

    //Llamada a la api
    API.getNextPageCharacters(page, (data) {
      //Se detiene el loader 
      Navigator.pop(context);

      setState(() {
        personajes = data.items;
        debugPrint("NUM: ${personajes.length}");
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarDbz(title: "Personajes"),
      drawer: const DrawerDbz(),
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), 
              topRight: Radius.circular(30)
            )
          ),
          child: Column(
            children: [
              //Titulo de la pagina
              const SaiyanTitle(title: "Personajes"),

              //Paginación
              Padding(
                padding: const EdgeInsets.only(top: 16, bottom: 10, left: 16, right: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Pagina $currentPage",
                          style: const TextStyle(
                            fontFamily: 'Oswald',
                            fontSize: 20
                          ),
                        ),
                        Text(
                          "Personajes $personajesInPage de $totalPersonajes",
                          style: TextStyle(
                            color: Colors.grey[700],
                            fontFamily: 'Oswald',
                            fontSize: 13
                          ),
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            if (currentPage != 1) {
                              setState(() {
                                currentPage -= 1;
                                _fetchNextPage(context, currentPage);
                                currentPage+1 == 6 ? personajesInPage -= 8 : personajesInPage -= personajes.length;
                              });
                              debugPrint("Pagina Anterioir: $currentPage");
                            } else {
                              debugPrint("No se puede retroceder");
                            }
                          },
                          child: Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              color: currentPage == 1 ? Colors.grey : const Color(0xffF47A20),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
                          ),
                        ),
                        const SizedBox(width: 9),
                        InkWell(
                          onTap: () {
                            if (currentPage < totalPages) {
                              setState(() {
                                currentPage += 1;
                                _fetchNextPage(context, currentPage);
                                currentPage == 6 ? personajesInPage += 8 : personajesInPage += personajes.length;
                              });
                              debugPrint("Pagina Siguiente: $currentPage");
                            } else {
                              debugPrint("No se puede avanzar");
                            }
                          },
                          child: Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              color: currentPage == totalPages ? Colors.grey : const Color(0xffF47A20),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Icon(Icons.arrow_forward_ios_rounded, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              //Lista de imagenes de los personajes.
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 9,
                  children: List.generate(personajes.length, (index) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 18, right: 18, top: 10),
                      child: CardPersonaje(
                        id: personajes[index].id,
                        name: personajes[index].name,
                        imageUrl: personajes[index].image,
                        model: personajes[index],
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}