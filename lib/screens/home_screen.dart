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

  @override
  void initState() {
    super.initState();
    _fetchPersonajes();
  }

  Future<void> _fetchPersonajes() async {
    API.getAllCharacters((response) {
      setState(() {
        personajes = response.items;
        debugPrint("Personajes: ${personajes.length}");
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
              const SaiyanTitle(title: "Personajes"),
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