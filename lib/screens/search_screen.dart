import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/audio_provider.dart';
import '../widgets/search_bar.dart';
import '../widgets/song_card.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomSearchBar(),
      ),
      body: Consumer<AudioProvider>(
        builder: (context, audioProvider, child) {
          if (audioProvider.searchResults.isEmpty) {
            return const Center(
              child: Text('No results found'),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: audioProvider.searchResults.length,
            itemBuilder: (context, index) {
              return SongCard(song: audioProvider.searchResults[index]);
            },
          );
        },
      ),
    );
  }
}
