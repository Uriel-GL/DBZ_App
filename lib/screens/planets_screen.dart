import 'package:dbz_app/models/planet.dart';
import 'package:dbz_app/network/api.dart';
import 'package:dbz_app/widgets/app-bar-dbz.dart';
import 'package:dbz_app/widgets/card_planeta.dart';
import 'package:dbz_app/widgets/drawer_dbz.dart';
import 'package:dbz_app/widgets/saiyan_title.dart';
import 'package:flutter/material.dart';

class PlanetsScreen extends StatefulWidget {
  const PlanetsScreen({super.key});

  @override
  State<PlanetsScreen> createState() => _PlanetsScreenState();
}

class _PlanetsScreenState extends State<PlanetsScreen> {
  List<Planeta> _planetas = [];
  int currentPage = 0;
  int totalPages = 0;
  int totalPlanetas = 0;
  int planetsInPage = 0;

  @override
  void initState() {
    super.initState();
    // Ejecuta después de que el widget se ha construido completamente.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchPlanetas(context);
    });
  }

  Future<void> _fetchPlanetas(BuildContext context) async {
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

    API.getAllPlanets((response) {
      Navigator.pop(context);

      setState(() {
        debugPrint("Planetas: ${response.items.length}");
        debugPrint("Paginas: ${response.meta.totalPages}");
        _planetas = response.items;
        currentPage = response.meta.currentPage;
        totalPages = response.meta.totalPages;
        totalPlanetas = response.meta.totalItems;
        planetsInPage = _planetas.length;
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
    API.getNextPagePlanets(page, (data) {
      //Se detiene el loader 
      Navigator.pop(context);

      setState(() {
        _planetas = data.items;
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
              const SaiyanTitle(title: "Planetas"),

              //Paginacion 
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
                          "Planetas $planetsInPage de $totalPlanetas",
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
                                planetsInPage = planetsInPage - _planetas.length;
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
                                planetsInPage = planetsInPage + _planetas.length;
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


              //Listado de planetas
              Expanded(
                child: GridView.count(
                  crossAxisCount: 1,
                  childAspectRatio: 2 / 1,
                  mainAxisSpacing: 15,
                  children: List.generate(_planetas.length, (index) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 18, right: 18, top: 10),
                      child: CardPlaneta(
                        idPlaneta: _planetas[index].id,
                        image: _planetas[index].image,
                        name: _planetas[index].name,
                        isDestroyed: _planetas[index].isDestroyed,
                        isDetail: false,
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
//'https://dragonball-api.com/planetas/Namek_U7.webp', 