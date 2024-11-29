import 'package:flutter/foundation.dart';
import '../models/song_model.dart';
import '../services/storage_service.dart';

class FavoritesProvider with ChangeNotifier {
  final StorageService _storageService;
  List<Song> _favorites = [];

  FavoritesProvider(this._storageService) {
    _loadFavorites();
  }

  List<Song> get favorites => _favorites;

  Future<void> _loadFavorites() async {
    _favorites = await _storageService.getFavorites();
    notifyListeners();
  }

  Future<void> toggleFavorite(Song song) async {
    final isFavorite = _favorites.any((s) => s.id == song.id);
    if (isFavorite) {
      _favorites.removeWhere((s) => s.id == song.id);
    } else {
      _favorites.add(song);
    }
    await _storageService.saveFavorites(_favorites);
    notifyListeners();
  }

  bool isFavorite(String songId) {
    return _favorites.any((song) => song.id == songId);
  }
}
