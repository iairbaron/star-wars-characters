import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/character.dart';

class CharacterService {
  static const String baseUrl =
      'https://akabab.github.io/starwars-api/api/all.json';

  Future<List<Character>> fetchCharacters() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));

      print('Status Code: ${response.statusCode}');
      print('Response Headers: ${response.headers}');

      if (response.statusCode == 200) {
        // Intentar decodificar el JSON primero
        final List<dynamic> data = json.decode(response.body) as List<dynamic>;
        print(
          'Datos decodificados correctamente. Número de personajes: ${data.length}',
        );

        // Convertir cada elemento a Character
        return data.map((json) {
          try {
            return Character.fromJson(json as Map<String, dynamic>);
          } catch (e) {
            print('Error al convertir personaje: $json');
            print('Error detallado: $e');
            rethrow;
          }
        }).toList();
      } else {
        throw Exception('Error del servidor: ${response.statusCode}');
      }
    } catch (e) {
      print('Error en fetchCharacters: $e');
      rethrow;
    }
  }
}
