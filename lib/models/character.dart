class Character {
  final int id;
  final String name;
  final String status;
  final String image;

  Character({required this.id, required this.name, required this.status, required this.image}); 

  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
    'status': status,
    'image': image,
  };

  factory Character.fromMap(Map<String, dynamic> map) {
    return Character(
      id: map['id'],
      name: map['name'],
      status: map['status'],
      image: map['image'],
    );
  }
}