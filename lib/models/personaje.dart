import 'package:dbz_app/models/planet.dart';

class Personaje {
  final int id;
  final String name;
  final String ki;
  final String maxKi;
  final String race;
  final String gender;
  final String description;
  final String image;
  final String affiliation;
  final Planeta? originPlanet;
  final List<Transformacion>? transformations;
  final String? deletedAt;

  Personaje({
    required this.id, 
    required this.name, 
    required this.ki, 
    required this.maxKi, 
    required this.race, 
    required this.gender, 
    required this.description, 
    required this.image, 
    required this.affiliation, 
    this.originPlanet,
    this.transformations,
    this.deletedAt, 
  });
    
  factory Personaje.fromJson(Map<String, dynamic> json) => Personaje(
    id: json['id'] ,
    name: json['name'] ,
    ki: json['ki'] ,
    maxKi: json['maxKi'] ,
    race: json['race'] ,
    gender: json['gender'] ,
    description: json['description'] ,
    image: json['image'] ,
    affiliation: json['affiliation'] ,
    originPlanet: json['originPlanet'] != null 
      ? Planeta.fromJson(json['originPlanet'])
      : null,
    transformations: json['transformations'] != null && (json['transformations'] as List).isNotEmpty
      ? List<Transformacion>.from(json['transformations'].map((x) => Transformacion.fromJson(x)))
      : null,
    deletedAt: json['deletedAt']
  );
}

class Transformacion {
  final int id;
  final String name;
  final String image;
  final String ki;
  final String? deletedAt;

  Transformacion({
    required this.id,
    required this.name,
    required this.image,
    required this.ki,
    this.deletedAt
  });

  factory Transformacion.fromJson(Map<String, dynamic> json) => Transformacion(
    id: json['id'], 
    name: json['name'], 
    image: json['image'],
    ki: json['ki'],
    deletedAt: json['deletedAt']
  );
}