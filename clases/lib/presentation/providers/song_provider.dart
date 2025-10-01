
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:clases/domain/songs.dart';

final selectedSongProvider = StateProvider<Song?>((ref) => null);

final songProvider = StateNotifierProvider<SongsNotifier, List<Song>>(
  (ref) => SongsNotifier(FirebaseFirestore.instance),
);

class SongsNotifier extends StateNotifier<List<Song>> {
  final FirebaseFirestore db;
  late final CollectionReference<Song> songsRef;

  SongsNotifier(this.db) : super([]) {
    songsRef = db.collection('songs').withConverter<Song>(
          fromFirestore: Song.fromFirestore,
          toFirestore: (Song song, _) => song.toFirestore(),
        );
  }

  Future<void> addSong(Song song) async {
    try {
      await songsRef.doc(song.id.toString()).set(song);
      state = [...state, song];
    } catch (e) {
      print('Error al agregar canción: $e');
    }
  }
  Future<void> updateSong(Song song) async {
    try {
      await songsRef.doc(song.id.toString()).set(song);
      state = [
        for (final s in state)
          if (s.id == song.id) song else s
      ];
    } catch (e) {
      print('Error al actualizar canción: $e');
    }
  }
  Future<void> deleteSong(int id) async {
    try {
      await songsRef.doc(id.toString()).delete();
      state = state.where((song) => song.id != id).toList();
    } catch (e) {
      print('Error al borrar canción: $e');
    }
  }
  Future<void> getAllSongs() async {
    try {
      final snap = await songsRef.get();
      state = snap.docs.map((d) => d.data()).toList();
    } catch (e) {
      print('Error al obtener canciones: $e');
    }
  }
}
