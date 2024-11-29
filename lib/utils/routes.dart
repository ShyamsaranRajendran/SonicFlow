import 'package:flutter/material.dart';
import '../screens/home_screen.dart';
import '../screens/song_player_screen.dart';
import '../screens/playlist_screen.dart';
import '../screens/search_screen.dart';
import '../models/song_model.dart';
import '../models/playlist_model.dart';

class AppRoutes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const HomeScreen());

      case '/player':
        final song = settings.arguments as Song;
        return MaterialPageRoute(
          builder: (_) => SongPlayerScreen(song: song),
        );

      case '/playlist':
        final playlist = settings.arguments as Playlist;
        return MaterialPageRoute(
          builder: (_) => PlaylistScreen(playlist: playlist),
        );

      case '/search':
        return MaterialPageRoute(builder: (_) => const SearchScreen());

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
