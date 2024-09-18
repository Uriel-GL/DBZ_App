class Planeta {
  final int id;
  final String name;
  final bool isDestroyed;
  final String description;
  final String image;
  final String? deletedAt;

  Planeta({
    required this.id,
    required this.name,
    required this.isDestroyed,
    required this.description,
    required this.image,
    this.deletedAt
  });

  factory Planeta.fromJson(Map<String, dynamic> json) => Planeta(
    id: json['id'], 
    name: json['name'], 
    isDestroyed: json['isDestroyed'], 
    description: json['description'], 
    image: json['image'],
    deletedAt: json['deletedAt']
  );
}