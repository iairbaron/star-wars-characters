import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/character_service.dart';
import '../models/character_state.dart';
import '../models/character.dart';

class CharacterController extends StateNotifier<CharacterState> {
  final CharacterService _service;

  CharacterController(this._service) : super(CharacterState.initial());

  Future<void> loadCharacters() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final characters = await _service.fetchCharacters();
      state = state.copyWith(
        allCharacters: characters,
        isLoading: false,
        error: null,
      );
      _updateDisplayedCharacters();
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Error al cargar los personajes: ${e.toString()}',
      );
    }
  }

  void search(String query) {
    final filtered = state.allCharacters
        .where((char) =>
            char.name.toLowerCase().contains(query.trim().toLowerCase()))
        .toList();

    state = state.copyWith(
      searchQuery: query,
      displayedCharacters: filtered,
      currentPage: 1, // Reset to first page when searching
    );
  }

  void nextPage() {
    if (state.hasNextPage) {
      state = state.copyWith(currentPage: state.currentPage + 1);
      _updateDisplayedCharacters();
    }
  }

  void previousPage() {
    if (state.hasPreviousPage) {
      state = state.copyWith(currentPage: state.currentPage - 1);
      _updateDisplayedCharacters();
    }
  }

  void _updateDisplayedCharacters() {
    final startIndex = (state.currentPage - 1) * state.itemsPerPage;
    final endIndex = startIndex + state.itemsPerPage;
    final List<Character> filteredCharacters = state.searchQuery.isEmpty
        ? state.allCharacters
        : state.allCharacters
            .where((char) => char.name
                .toLowerCase()
                .contains(state.searchQuery.trim().toLowerCase()))
            .toList();

    final List<Character> paginatedCharacters = filteredCharacters.length > startIndex
        ? filteredCharacters.sublist(
            startIndex,
            endIndex > filteredCharacters.length
                ? filteredCharacters.length
                : endIndex,
          )
        : [];

    state = state.copyWith(displayedCharacters: paginatedCharacters);
  }
}

final characterControllerProvider =
    StateNotifierProvider<CharacterController, CharacterState>(
  (ref) => CharacterController(CharacterService()),
);
