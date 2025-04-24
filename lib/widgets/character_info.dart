import 'package:flutter/material.dart';
import '../models/character.dart';

class CharacterInfo extends StatelessWidget {
  final Character character;

  const CharacterInfo({
    super.key,
    required this.character,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          character.name,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 4),
        Text(
          character.gender,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 12,
          ),
        ),
        if (character.birthYear != null) ...[
          const SizedBox(height: 4),
          Text(
            'Nacimiento: ${character.birthYear}',
            style: const TextStyle(
              fontSize: 11,
              color: Colors.grey,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
        if (character.homeworld != null) ...[
          const SizedBox(height: 4),
          Text(
            'Planeta: ${character.homeworld}',
            style: const TextStyle(
              fontSize: 11,
              color: Colors.grey,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ],
    );
  }
} 