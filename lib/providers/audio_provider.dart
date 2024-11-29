import 'package:flutter/foundation.dart';
import '../models/song_model.dart';
import '../models/playlist_model.dart';
import '../services/audio_service.dart';

class AudioProvider with ChangeNotifier {
  final AudioPlayerService audioService = AudioPlayerService();
  List<Song> _songs = [];
  List<Song> _recentSongs = [];
  List<Playlist> _playlists = [];
  List<Song> _searchResults = [];
  Song? _currentSong;
  bool _isPlaying = false;

  List<Song> get songs => _songs;
  List<Song> get recentSongs => _recentSongs;
  List<Playlist> get playlists => _playlists;
  List<Song> get searchResults => _searchResults;
  Song? get currentSong => _currentSong;
  bool get isPlaying => _isPlaying;

  void setSongs(List<Song> songs) {
    _songs = songs;
    notifyListeners();
  }

  void setPlaylists(List<Playlist> playlists) {
    _playlists = playlists;
    notifyListeners();
  }

  Future<void> playSong(Song song) async {
    _currentSong = song;
    _isPlaying = true;
    await audioService.playSong(song);
    _addToRecentSongs(song);
    notifyListeners();
  }

  void _addToRecentSongs(Song song) {
    _recentSongs.remove(song);
    _recentSongs.insert(0, song);
    if (_recentSongs.length > 10) {
      _recentSongs.removeLast();
    }
    notifyListeners();
  }

  Future<void> togglePlayPause() async {
    if (_currentSong == null) return;

    if (_isPlaying) {
      await audioService.pause();
    } else {
      await audioService.resume();
    }
    _isPlaying = !_isPlaying;
    notifyListeners();
  }

  Future<void> playNext() async {
    if (_currentSong == null) return;
    final currentIndex = _songs.indexOf(_currentSong!);
    if (currentIndex < _songs.length - 1) {
      await playSong(_songs[currentIndex + 1]);
    }
  }

  Future<void> playPrevious() async {
    if (_currentSong == null) return;
    final currentIndex = _songs.indexOf(_currentSong!);
    if (currentIndex > 0) {
      await playSong(_songs[currentIndex - 1]);
    }
  }

  void search(String query) {
    if (query.isEmpty) {
      _searchResults = [];
    } else {
      _searchResults = _songs.where((song) {
        return song.title.toLowerCase().contains(query.toLowerCase()) ||
            song.artist.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }
    notifyListeners();
  }

  @override
  void dispose() {
    audioService.dispose();
    super.dispose();
  }
}
