import 'package:dbz_app/models/base_response.dart';
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

  @override
  void initState() {
    super.initState();
    _fetchPersonajes();
  }

  Future<void> _fetchPersonajes() async {
    API.getAllCharacters((response) {
      setState(() {
        personajes = response.items;
        currentPage = response.meta.currentPage; //Valor inicial
        totalPages = response.meta.totalPages; 
        debugPrint("Personajes: ${personajes.length}");
        debugPrint("Paginas: $totalPages");
      });
    });
  }

  Future<void> _fetchNextPagePersonajes(int page) async {

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
                    const Text(
                      "Pagina 1",
                      style: TextStyle(
                        fontFamily: 'Oswald',
                        fontSize: 20
                      ),
                    ),

                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            if (currentPage != 1) {
                              setState(() {
                                currentPage -= 1;
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
                              color: currentPage == 6 ? Colors.grey : const Color(0xffF47A20),
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