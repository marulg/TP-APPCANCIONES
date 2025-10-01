import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:clases/presentation/providers/song_provider.dart';
import 'package:go_router/go_router.dart';

class SongDetail extends ConsumerWidget {
  const SongDetail({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final song = ref.watch(selectedSongProvider);

    if (song == null) {
      return const Scaffold(
        body: Center(child: Text('No se seleccionó ninguna canción')),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(song.name)), 
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  song.cover, // imagen de la tapa del disco
                  width: 200,
                  height: 200,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.broken_image, size: 80),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text('Artista: ${song.artist}', style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 10),
            Text('Álbum: ${song.album}', style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          
          FloatingActionButton(
            onPressed: () {
              context.pushNamed('editSong'); 
            },
            child: const Icon(Icons.edit),
          ),

          const SizedBox(height: 10),

          FloatingActionButton(
            onPressed: () async {
              await ref.read(songProvider.notifier).deleteSong(song.id);
              context.go('/home');
            },
            child: const Icon(Icons.delete),
          ),
        ],
      ),
    );
  }
}
