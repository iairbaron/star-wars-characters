import 'package:flutter/material.dart';
import '../models/character.dart';
import 'character_card.dart';

class CharacterGrid extends StatelessWidget {
  final List<Character> characters;

  const CharacterGrid({
    super.key,
    required this.characters,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 0.75,
      ),
      itemCount: characters.length,
      itemBuilder: (context, index) {
        final character = characters[index];
        return CharacterCard(character: character);
      },
    );
  }
} 