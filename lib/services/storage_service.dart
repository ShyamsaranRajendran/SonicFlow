import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/playlist_model.dart';
import '../models/song_model.dart';

class StorageService {
  static const String _favoritesKey = 'favorites';
  static const String _playlistsKey = 'playlists';
  late SharedPreferences _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<void> saveFavorites(List<Song> favorites) async {
    final String encodedFavorites = json.encode(
      favorites.map((song) => song.toJson()).toList(),
    );
    await _prefs.setString(_favoritesKey, encodedFavorites);
  }

  Future<List<Song>> getFavorites() async {
    final String? encodedFavorites = _prefs.getString(_favoritesKey);
    if (encodedFavorites == null) return [];

    final List<dynamic> decodedFavorites = json.decode(encodedFavorites);
    return decodedFavorites.map((json) => Song.fromJson(json)).toList();
  }

  Future<void> savePlaylists(List<Playlist> playlists) async {
    final String encodedPlaylists = json.encode(
      playlists.map((playlist) => playlist.toJson()).toList(),
    );
    await _prefs.setString(_playlistsKey, encodedPlaylists);
  }

  Future<List<Playlist>> getPlaylists() async {
    final String? encodedPlaylists = _prefs.getString(_playlistsKey);
    if (encodedPlaylists == null) return [];

    final List<dynamic> decodedPlaylists = json.decode(encodedPlaylists);
    return decodedPlaylists.map((json) => Playlist.fromJson(json)).toList();
  }
}
