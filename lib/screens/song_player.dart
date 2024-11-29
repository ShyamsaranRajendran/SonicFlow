import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/audio_provider.dart';
import '../models/song_model.dart';

class SongPlayerScreen extends StatelessWidget {
  final Song song;

  const SongPlayerScreen({super.key, required this.song});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Consumer<AudioProvider>(
        builder: (context, audioProvider, child) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Hero(
                tag: 'album-art-${song.id}',
                child: Container(
                  width: 300,
                  height: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                    image: DecorationImage(
                      image: NetworkImage(song.albumArt),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              Text(
                song.title,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                song.artist,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 40),
              StreamBuilder<Duration>(
                stream: audioProvider.audioService.positionStream,
                builder: (context, snapshot) {
                  final position = snapshot.data ?? Duration.zero;
                  return Slider(
                    value: position.inSeconds.toDouble(),
                    max: song.duration.inSeconds.toDouble(),
                    onChanged: (value) {
                      audioProvider.audioService.seek(
                        Duration(seconds: value.toInt()),
                      );
                    },
                  );
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: const Icon(Icons.skip_previous, size: 40),
                    onPressed: () => audioProvider.playPrevious(),
                  ),
                  IconButton(
                    icon: Icon(
                      audioProvider.isPlaying
                          ? Icons.pause_circle_filled
                          : Icons.play_circle_filled,
                      size: 64,
                    ),
                    onPressed: () => audioProvider.togglePlayPause(),
                  ),
                  IconButton(
                    icon: const Icon(Icons.skip_next, size: 40),
                    onPressed: () => audioProvider.playNext(),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
