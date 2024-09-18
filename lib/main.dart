import 'package:dbz_app/screens/home.dart';
import 'package:dbz_app/widgets/app-bar-dbz.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "App DBZ",
      home: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBarDbz(title: "Dragon Ball"),
        body: Padding(
          padding: EdgeInsets.only(top: 10), //Simulación de espacio entre AppBar y contenido
          child: Home(),
        ),
      ),
    );
  }
}