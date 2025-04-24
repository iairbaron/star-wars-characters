import 'package:flutter/material.dart';
import '../models/character.dart';

class CharacterCard extends StatelessWidget {
  final Character character;

  const CharacterCard({
    super.key,
    required this.character,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
                color: Colors.black12,
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
                child: Image.network(
                  character.image,
                  fit: BoxFit.fill,
                  width: double.infinity,
                  height: double.infinity,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.image_not_supported, size: 50),
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
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
              ),
            ),
          ),
        ],
      ),
    );
  }
} 