import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/character_state.dart';
import '../services/character_service.dart';
import '../services/storage_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

final storageServiceProvider = StateProvider<StorageService?>((ref) => null);

final initializeStorageProvider = FutureProvider<void>((ref) async {
  final prefs = await SharedPreferences.getInstance();
  ref.read(storageServiceProvider.notifier).state = StorageService(prefs);
});

final characterControllerProvider =
    StateNotifierProvider<CharacterController, CharacterState>((ref) {
  final storageService = ref.watch(storageServiceProvider);
  if (storageService == null) {
    throw Exception('StorageService not initialized');
  }
  return CharacterController(
    CharacterService(),
    storageService,
  );
});

class CharacterController extends StateNotifier<CharacterState> {
  final CharacterService _characterService;
  final StorageService _storageService;

  CharacterController(this._characterService, this._storageService)
      : super(CharacterState.initial());

  Future<void> loadCharacters() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final characters = await _characterService.fetchCharacters();
      final favoriteIds = await _storageService.getFavoriteCharacterIds();
      
      final charactersWithFavorites = characters.map((character) {
        return character.copyWith(
          isFavorite: favoriteIds.contains(character.id),
        );
      }).toList();

      state = state.copyWith(
        allCharacters: charactersWithFavorites,
        displayedCharacters: charactersWithFavorites,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Error al cargar los personajes: $e',
      );
    }
  }

  Future<void> toggleFavorite(int characterId) async {
    await _storageService.toggleFavoriteCharacter(characterId);
    
    state = state.copyWith(
      allCharacters: state.allCharacters.map((character) {
        if (character.id == characterId) {
          return character.copyWith(isFavorite: !character.isFavorite);
        }
        return character;
      }).toList(),
      displayedCharacters: state.displayedCharacters.map((character) {
        if (character.id == characterId) {
          return character.copyWith(isFavorite: !character.isFavorite);
        }
        return character;
      }).toList(),
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

  void search(String query) {
    if (query.isEmpty) {
      state = state.copyWith(
        searchQuery: '',
        displayedCharacters: state.allCharacters,
        currentPage: 1,
      );
    } else {
      final filteredCharacters = state.allCharacters
          .where((character) =>
              character.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
      state = state.copyWith(
        searchQuery: query,
        displayedCharacters: filteredCharacters,
        currentPage: 1,
      );
    }
  }

  void _updateDisplayedCharacters() {
    final start = (state.currentPage - 1) * state.itemsPerPage;
    final end = start + state.itemsPerPage;
    final filteredCharacters = state.filteredCharacters;

    state = state.copyWith(
      displayedCharacters: filteredCharacters.sublist(
        start,
        end.clamp(0, filteredCharacters.length),
      ),
    );
  }

  void toggleFavoriteFilter() {
    state = state.copyWith(
      showOnlyFavorites: !state.showOnlyFavorites,
      currentPage: 1,
    );
    _updateDisplayedCharacters();
  }
}
