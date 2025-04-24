import 'character.dart';

class CharacterState {
  final List<Character> allCharacters;
  final List<Character> displayedCharacters;
  final bool isLoading;
  final String searchQuery;
  final String? error;

  CharacterState({
    required this.allCharacters,
    required this.displayedCharacters,
    required this.isLoading,
    required this.searchQuery,
    this.error,
  });

  CharacterState copyWith({
    List<Character>? allCharacters,
    List<Character>? displayedCharacters,
    bool? isLoading,
    String? searchQuery,
    String? error,
  }) {
    return CharacterState(
      allCharacters: allCharacters ?? this.allCharacters,
      displayedCharacters: displayedCharacters ?? this.displayedCharacters,
      isLoading: isLoading ?? this.isLoading,
      searchQuery: searchQuery ?? this.searchQuery,
      error: error,
    );
  }

  factory CharacterState.initial() {
    return CharacterState(
      allCharacters: [],
      displayedCharacters: [],
      isLoading: false,
      searchQuery: '',
      error: null,
    );
  }
}
