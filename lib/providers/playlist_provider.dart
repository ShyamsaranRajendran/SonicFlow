import 'package:flutter/foundation.dart';
import '../models/playlist_model.dart';
import '../models/song_model.dart';
import '../services/storage_service.dart';

class PlaylistProvider with ChangeNotifier {
  final StorageService _storageService;
  List<Playlist> _playlists = [];

  PlaylistProvider(this._storageService) {
    _loadPlaylists();
  }

  List<Playlist> get playlists => _playlists;

  Future<void> _loadPlaylists() async {
    _playlists = await _storageService.getPlaylists();
    notifyListeners();
  }

  Future<void> createPlaylist(String name, String description) async {
    final newPlaylist = Playlist(
      id: DateTime.now().toString(),
      name: name,
      description: description,
      songs: [],
      coverImage: 'assets/images/default_album_art.png',
    );

    _playlists.add(newPlaylist);
    await _storageService.savePlaylists(_playlists);
    notifyListeners();
  }

  Future<void> addSongToPlaylist(String playlistId, Song song) async {
    final playlistIndex = _playlists.indexWhere((p) => p.id == playlistId);
    if (playlistIndex != -1) {
      final updatedSongs = [..._playlists[playlistIndex].songs, song];
      _playlists[playlistIndex] = Playlist(
        id: _playlists[playlistIndex].id,
        name: _playlists[playlistIndex].name,
        description: _playlists[playlistIndex].description,
        songs: updatedSongs,
        coverImage: _playlists[playlistIndex].coverImage,
      );
      await _storageService.savePlaylists(_playlists);
      notifyListeners();
    }
  }

  Future<void> removeSongFromPlaylist(String playlistId, String songId) async {
    final playlistIndex = _playlists.indexWhere((p) => p.id == playlistId);
    if (playlistIndex != -1) {
      final updatedSongs = _playlists[playlistIndex]
          .songs
          .where((song) => song.id != songId)
          .toList();
      _playlists[playlistIndex] = Playlist(
        id: _playlists[playlistIndex].id,
        name: _playlists[playlistIndex].name,
        description: _playlists[playlistIndex].description,
        songs: updatedSongs,
        coverImage: _playlists[playlistIndex].coverImage,
      );
      await _storageService.savePlaylists(_playlists);
      notifyListeners();
    }
  }

  Future<void> deletePlaylist(String playlistId) async {
    _playlists.removeWhere((playlist) => playlist.id == playlistId);
    await _storageService.savePlaylists(_playlists);
    notifyListeners();
  }
}
