import 'package:flutter/material.dart';
import '../models/character.dart';
import 'character_card.dart';

class CharacterGrid extends StatelessWidget {
  final List<Character> characters;

  const CharacterGrid({
    super.key,
    required this.characters,
  });

  int _getCrossAxisCount(double width) {
    if (width < 600) return 1;  // Móviles
    if (width < 900) return 2;  // Tablets pequeñas
    if (width < 1200) return 3; // Tablets grandes
    if (width < 1500) return 4; // Pantallas medianas
    return 5;                   // Pantallas grandes
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount = _getCrossAxisCount(constraints.maxWidth);
        
        return GridView.builder(
          padding: const EdgeInsets.all(8),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 0.7,
          ),
          itemCount: characters.length,
          itemBuilder: (context, index) {
            final character = characters[index];
            return CharacterCard(character: character);
          },
        );
      },
    );
  }
} 