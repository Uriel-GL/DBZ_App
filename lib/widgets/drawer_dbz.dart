import 'package:dbz_app/screens/home_screen.dart';
import 'package:dbz_app/screens/planets_screen.dart';
import 'package:dbz_app/screens/profile_screen.dart';
import 'package:flutter/material.dart';

class DrawerDbz extends StatelessWidget {
  const DrawerDbz({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Column(children: [
            Image.asset('assets/images/banner.png'),
            const Center(
                child: Text(
              "Bienvenido",
              style: TextStyle(
                  fontFamily: 'Oswald', fontSize: 26, color: Color(0xffF47A20)),
            ))
          ]),
          const SizedBox(height: 10),
          ListTile(
            title: const Text(
              "Personajes",
              style: TextStyle(fontFamily: 'Oswald', fontSize: 22),
            ),
            leading: Image.asset('assets/icons/icon_personajes.png',
                width: 30, height: 30),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const Home()));
            },
          ),
          ListTile(
            title: const Text("Planetas",
                style: TextStyle(fontFamily: 'Oswald', fontSize: 22)),
            leading: Image.asset('assets/icons/globe_icon.png',
                width: 30, height: 30),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const PlanetsScreen()));
            },
          ),
          ListTile(
            title: const Text("Perfil",
                style: TextStyle(fontFamily: 'Oswald', fontSize: 22)),
            leading: Image.asset('assets/icons/icon_profile.png',
                width: 30, height: 30),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfileScreen()));
            },
          ),
        ],
      ),
    );
  }
}
