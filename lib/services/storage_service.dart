import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static const String _favoritesKey = 'favorite_characters';
  final SharedPreferences _prefs;

  StorageService(this._prefs);

  Future<Set<int>> getFavoriteCharacterIds() async {
    final String? favoritesJson = _prefs.getString(_favoritesKey);
    if (favoritesJson == null) return {};
    
    final List<dynamic> favoritesList = json.decode(favoritesJson);
    return favoritesList.map((id) => id as int).toSet();
  }

  Future<void> toggleFavoriteCharacter(int characterId) async {
    final favorites = await getFavoriteCharacterIds();
    
    if (favorites.contains(characterId)) {
      favorites.remove(characterId);
    } else {
      favorites.add(characterId);
    }

    await _prefs.setString(_favoritesKey, json.encode(favorites.toList()));
  }

  Future<bool> isFavoriteCharacter(int characterId) async {
    final favorites = await getFavoriteCharacterIds();
    return favorites.contains(characterId);
  }
} 