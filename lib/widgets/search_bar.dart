import 'package:flutter/material.dart';

class CharacterSearchBar extends StatelessWidget implements PreferredSizeWidget {
  final Function(String) onSearch;

  const CharacterSearchBar({
    super.key,
    required this.onSearch,
  });

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(48.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: TextField(
          decoration: const InputDecoration(
            hintText: 'Buscar personaje...',
            prefixIcon: Icon(Icons.search),
          ),
          onChanged: onSearch,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(48.0);
} 