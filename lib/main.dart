import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'providers/audio_provider.dart';
import 'providers/playlist_provider.dart';
import 'providers/favorites_provider.dart';
import 'services/storage_service.dart';
import 'utils/theme.dart';
import 'utils/routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize JustAudioBackground
  await JustAudioBackground.init(
    androidNotificationChannelId:
        'com.example.flutter_music_player.channel.audio',
    androidNotificationChannelName: 'Audio Playback',
    androidNotificationOngoing: true,
  );

  // Initialize the storage service
  final storageService = StorageService();
  await storageService.init();

  runApp(MyApp(storageService: storageService));
}

class MyApp extends StatelessWidget {
  final StorageService storageService;

  const MyApp({Key? key, required this.storageService}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AudioProvider()),
        ChangeNotifierProvider(
          create: (_) => PlaylistProvider(storageService),
        ),
        ChangeNotifierProvider(
          create: (_) => FavoritesProvider(storageService),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Music Player',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
        onGenerateRoute: AppRoutes.generateRoute,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
