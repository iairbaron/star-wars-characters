class Character {
  final int id;
  final String name;
  final String image;
  final String gender;
  final double? height;
  final double? mass;
  final String? homeworld;
  final String? species;
  final String? birthYear;
  final List<String>? affiliations;

  Character({
    required this.id,
    required this.name,
    required this.image,
    required this.gender,
    this.height,
    this.mass,
    this.homeworld,
    this.species,
    this.birthYear,
    this.affiliations,
  });

  factory Character.fromJson(Map<String, dynamic> json) {
    // Función auxiliar para manejar conversiones seguras
    T? safeCast<T>(dynamic value) {
      if (value == null) return null;
      if (value is T) return value;
      print('Warning: Could not cast $value to $T');
      return null;
    }

    // Función para convertir a double de manera segura
    double? toDouble(dynamic value) {
      if (value == null) return null;
      if (value is num) return value.toDouble();
      if (value is String) return double.tryParse(value);
      return null;
    }

    try {
      return Character(
        id: json['id'] is String ? int.parse(json['id']) : json['id'],
        name: json['name']?.toString() ?? 'Unknown',
        image: json['image']?.toString() ?? 'https://via.placeholder.com/150',
        gender: json['gender']?.toString() ?? 'Unknown',
        height: toDouble(json['height']),
        mass: toDouble(json['mass']),
        homeworld: safeCast<String>(json['homeworld']),
        species: safeCast<String>(json['species']),
        birthYear: json['born']?.toString(),
        affiliations: (json['affiliations'] as List<dynamic>?)
            ?.map((e) => e.toString())
            .toList() ?? [],
      );
    } catch (e) {
      print('Error parsing character: $json');
      print('Error details: $e');
      rethrow;
    }
  }
}

