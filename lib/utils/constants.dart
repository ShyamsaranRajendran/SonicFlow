class AppConstants {
  static const String appName = 'Flutter Music Player';
  static const String defaultAlbumArt = 'assets/images/default_album_art.png';
  static const String appLogo = 'assets/images/app_logo.png';

  // Route names
  static const String homeRoute = '/';
  static const String playerRoute = '/player';
  static const String playlistRoute = '/playlist';
  static const String searchRoute = '/search';

  // Storage keys
  static const String favoritesKey = 'favorites';
  static const String playlistsKey = 'playlists';
  static const String recentlyPlayedKey = 'recently_played';

  // Error messages
  static const String audioLoadError = 'Failed to load audio';
  static const String playlistCreateError = 'Failed to create playlist';
  static const String storageError = 'Storage operation failed';
}
