import 'character.dart';

class CharacterState {
  final List<Character> allCharacters;
  final List<Character> displayedCharacters;
  final bool isLoading;
  final String searchQuery;
  final String? error;
  final int currentPage;
  final int itemsPerPage;
  final bool showOnlyFavorites;

  CharacterState({
    required this.allCharacters,
    required this.displayedCharacters,
    required this.isLoading,
    required this.searchQuery,
    this.error,
    required this.currentPage,
    required this.itemsPerPage,
    required this.showOnlyFavorites,
  });

  CharacterState copyWith({
    List<Character>? allCharacters,
    List<Character>? displayedCharacters,
    bool? isLoading,
    String? searchQuery,
    String? error,
    int? currentPage,
    int? itemsPerPage,
    bool? showOnlyFavorites,
  }) {
    return CharacterState(
      allCharacters: allCharacters ?? this.allCharacters,
      displayedCharacters: displayedCharacters ?? this.displayedCharacters,
      isLoading: isLoading ?? this.isLoading,
      searchQuery: searchQuery ?? this.searchQuery,
      error: error,
      currentPage: currentPage ?? this.currentPage,
      itemsPerPage: itemsPerPage ?? this.itemsPerPage,
      showOnlyFavorites: showOnlyFavorites ?? this.showOnlyFavorites,
    );
  }

  factory CharacterState.initial() {
    return CharacterState(
      allCharacters: [],
      displayedCharacters: [],
      isLoading: false,
      searchQuery: '',
      error: null,
      currentPage: 1,
      itemsPerPage: 12,
      showOnlyFavorites: false,
    );
  }

  int get totalPages => (filteredCharacters.length / itemsPerPage).ceil();
  bool get hasNextPage => currentPage < totalPages;
  bool get hasPreviousPage => currentPage > 1;

  List<Character> get filteredCharacters {
    List<Character> filtered = allCharacters;
    
    if (showOnlyFavorites) {
      filtered = filtered.where((char) => char.isFavorite).toList();
    }
    
    if (searchQuery.isNotEmpty) {
      filtered = filtered
          .where((char) =>
              char.name.toLowerCase().contains(searchQuery.toLowerCase()))
          .toList();
    }
    
    return filtered;
  }
}
