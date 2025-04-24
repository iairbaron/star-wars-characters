import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/character_service.dart';
import '../models/character_state.dart';

class CharacterController extends StateNotifier<CharacterState> {
  final CharacterService _service;

  CharacterController(this._service) : super(CharacterState.initial());

  Future<void> loadCharacters() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final characters = await _service.fetchCharacters();
      print("characters" + characters.length.toString());
      state = state.copyWith(
        allCharacters: characters,
        displayedCharacters: characters,
        isLoading: false,
        error: null,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Error al cargar los personajes: ${e.toString()}',
      );
    }
  }

  void search(String query) {
    final filtered =
        state.allCharacters
            .where(
              (char) =>
                  char.name.toLowerCase().contains(query.trim().toLowerCase()),
            )
            .toList();

    state = state.copyWith(searchQuery: query, displayedCharacters: filtered);
  }
}

final characterControllerProvider =
    StateNotifierProvider<CharacterController, CharacterState>(
      (ref) => CharacterController(CharacterService()),
    );
