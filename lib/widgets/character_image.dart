import 'package:flutter/material.dart';

class CharacterImage extends StatelessWidget {
  final String imageUrl;

  const CharacterImage({
    super.key,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
        color: Colors.black12,
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
        child: Image.network(
          imageUrl,
          fit: BoxFit.fill, 
          width: double.infinity,
          height: double.infinity,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              alignment: Alignment.center,
              color: Colors.grey[300],
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.image_not_supported, size: 50, color: Colors.grey),
                  SizedBox(height: 8),
                  Text('Imagen no disponible', style: TextStyle(color: Colors.grey)),
                ],
              ),
            );
          },
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
