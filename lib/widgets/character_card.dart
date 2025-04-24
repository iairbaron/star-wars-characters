import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/character.dart';
import '../controllers/character_controller.dart';
import 'character_info.dart';
import 'character_image.dart';

class CharacterCard extends ConsumerWidget {
  final Character character;

  const CharacterCard({
    super.key,
    required this.character,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      children: [
        Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 3,
                child: CharacterImage(imageUrl: character.image),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CharacterInfo(character: character),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 8,
          right: 8,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                ref.read(characterControllerProvider.notifier).toggleFavorite(character.id);
              },
              customBorder: const CircleBorder(),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  character.isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: character.isFavorite ? Colors.red : Colors.grey,
                  size: 24,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
} 