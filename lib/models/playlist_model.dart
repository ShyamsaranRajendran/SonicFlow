import 'song_model.dart';

class Playlist {
  final String id;
  final String name;
  final String description;
  final List<Song> songs;
  final String coverImage;

  Playlist({
    required this.id,
    required this.name,
    required this.description,
    required this.songs,
    required this.coverImage,
  });

  factory Playlist.fromJson(Map<String, dynamic> json) {
    return Playlist(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      songs:
          (json['songs'] as List).map((song) => Song.fromJson(song)).toList(),
      coverImage: json['coverImage'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'songs': songs.map((song) => song.toJson()).toList(),
      'coverImage': coverImage,
    };
  }
}
