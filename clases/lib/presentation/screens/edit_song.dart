import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:clases/domain/songs.dart';
import 'package:clases/presentation/providers/song_provider.dart'; 
import 'package:go_router/go_router.dart';

class EditSongScreen extends ConsumerWidget {
  const EditSongScreen({super.key});
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final song = ref.watch(selectedSongProvider);

    final TextEditingController nameController = TextEditingController(text: song!.name);
    final TextEditingController artistController = TextEditingController(text: song.artist);
    final TextEditingController albumController = TextEditingController(text: song.album);
    final TextEditingController coverController = TextEditingController(text: song.cover);

    return Scaffold(
      appBar: AppBar(title: const Text("Editar Canción")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: "Nombre"),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: artistController,
              decoration: const InputDecoration(labelText: "Artista"),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: albumController,
              decoration: const InputDecoration(labelText: "Álbum"),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: coverController,
              decoration: const InputDecoration(labelText: "Cover URL"),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () async {
                final name = nameController.text.trim();
                final artist = artistController.text.trim();
                final album = albumController.text.trim();
                final cover = coverController.text.trim();
                final id = song.id;

                final newSong = Song(
                  id: id,
                  name: name,
                  artist: artist,
                  album: album,
                  cover: cover,
                );
                await ref.read(songProvider.notifier).updateSong(newSong);
                context.go('/home');
              },
              child: const Text("Guardar"),
            ),
          ],
        ),
      ),
    );
  }
}
