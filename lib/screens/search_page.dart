import 'package:flutter/material.dart';
import '../models/character.dart';
import '../widgets/character_grid.dart';

class SearchPage extends StatefulWidget {
  final List<Character> allCharacters;

  const SearchPage({
    super.key,
    required this.allCharacters,
  });

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  List<Character> _filteredCharacters = [];
  bool _hasSearched = false;

  void _performSearch(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredCharacters = [];
        _hasSearched = false;
      } else {
        _filteredCharacters = widget.allCharacters
            .where((character) =>
                character.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
        _hasSearched = true;
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buscar Personaje'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              autofocus: true,
              decoration: InputDecoration(
                hintText: 'Buscar personaje...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          _performSearch('');
                        },
                      )
                    : null,
                filled: true,
                fillColor: Theme.of(context).colorScheme.surface,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.primary,
                    width: 2,
                  ),
                ),
              ),
              onChanged: _performSearch,
            ),
          ),
        ),
      ),
      body: _hasSearched
          ? _filteredCharacters.isEmpty
              ? const Center(
                  child: Text(
                    'No se encontraron personajes',
                    style: TextStyle(fontSize: 16),
                  ),
                )
              : CharacterGrid(characters: _filteredCharacters)
          : const Center(
              child: Text(
                'Ingresa un nombre para buscar',
                style: TextStyle(fontSize: 16),
              ),
            ),
    );
  }
} 