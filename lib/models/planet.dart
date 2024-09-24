import 'package:dbz_app/models/personaje.dart';

class Planeta {
  final int id;
  final String name;
  final bool isDestroyed;
  final String description;
  final String image;
  final String? deletedAt;
  final List<Personaje>? characters;

  Planeta({
    required this.id,
    required this.name,
    required this.isDestroyed,
    required this.description,
    required this.image,
    this.deletedAt,
    this.characters
  });

  factory Planeta.fromJson(Map<String, dynamic> json) => Planeta(
    id: json['id'], 
    name: json['name'], 
    isDestroyed: json['isDestroyed'], 
    description: json['description'], 
    image: json['image'],
    deletedAt: json['deletedAt'],
    characters: json['characters'] != null && (json['characters'] as List).isNotEmpty
      ? List<Personaje>.from(json['characters'].map((x) => Personaje.fromJson(x)))
      : null,
  );
}