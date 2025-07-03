import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:clases/entities/songs.dart';

// este provider guarda la lista de canciones y permite modificarla
final songsProvider = StateProvider<List<Song>>((ref) => [...songs]);

// este guarda la canción q el user selecciona en el home para ver detalles
final selectedSongProvider = StateProvider<Song?>((ref) => null);
