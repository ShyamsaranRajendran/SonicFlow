import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/audio_provider.dart';
import '../widgets/song_card.dart';
import '../widgets/playlist_card.dart';
import '../widgets/mini_player.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Music Player'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => Navigator.pushNamed(context, '/search'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Recently Played',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            Consumer<AudioProvider>(
              builder: (context, audioProvider, child) {
                return SizedBox(
                  height: 200,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: audioProvider.recentSongs.length,
                    itemBuilder: (context, index) {
                      return SongCard(song: audioProvider.recentSongs[index]);
                    },
                  ),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Your Playlists',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            Consumer<AudioProvider>(
              builder: (context, audioProvider, child) {
                return SizedBox(
                  height: 200,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: audioProvider.playlists.length,
                    itemBuilder: (context, index) {
                      return PlaylistCard(
                          playlist: audioProvider.playlists[index]);
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: const MiniPlayer(),
    );
  }
}
