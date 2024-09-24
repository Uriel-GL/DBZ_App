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

  @override
  void initState() {
    super.initState();
    _fetchPlanetas();
  }

  Future<void> _fetchPlanetas() async {
    API.getAllPlanets((response) {
      setState(() {
        debugPrint("Planetas: ${response.items.length}");
        _planetas = response.items;
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
              const SaiyanTitle(title: "Planetas"),
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