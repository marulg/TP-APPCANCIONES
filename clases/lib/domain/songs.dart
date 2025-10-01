import 'package:cloud_firestore/cloud_firestore.dart';

class Song {
  final int id;
  final String name;
  final String artist;
  final String album;
  final String cover;

  Song({
    required this.id,
    required this.name,
    required this.artist,
    required this.album,
    required this.cover,
  });

  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'name': name,
      'artist': artist,
      'album': album,
      'cover': cover,
    };
  }

  static Song fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Song(
      id: data?['id'],
      name: data?['name'],
      artist: data?['artist'],
      album: data?['album'],
      cover: data?['cover'],
    );
    }
}