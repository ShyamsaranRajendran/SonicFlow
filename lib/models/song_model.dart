class Song {
  final String id;
  final String title;
  final String artist;
  final String albumArt;
  final String filePath;
  final Duration duration;

  Song({
    required this.id,
    required this.title,
    required this.artist,
    required this.albumArt,
    required this.filePath,
    required this.duration,
  });

  factory Song.fromJson(Map<String, dynamic> json) {
    return Song(
      id: json['id'],
      title: json['title'],
      artist: json['artist'],
      albumArt: json['albumArt'],
      filePath: json['filePath'],
      duration: Duration(milliseconds: json['duration']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'artist': artist,
      'albumArt': albumArt,
      'filePath': filePath,
      'duration': duration.inMilliseconds,
    };
  }
}
