import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:clases/domain/songs.dart';
import 'package:clases/presentation/providers/song_provider.dart'; 
import 'package:go_router/go_router.dart';

class NewSongScreen extends ConsumerWidget {
  NewSongScreen({super.key});

  final TextEditingController nameController = TextEditingController();
  final TextEditingController artistController = TextEditingController();
  final TextEditingController albumController = TextEditingController();
  final TextEditingController coverController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text("Nueva Canción")),
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
                
                final songList = ref.watch(songProvider);

                final lastSong = songList.isNotEmpty ? songList[songList.length - 1] : null;
                int newId = lastSong != null ? lastSong.id + 1 : 1;

                final newSong = Song(
                  id: newId,
                  name: name,
                  artist: artist,
                  album: album,
                  cover: cover,
                );

                await ref.read(songProvider.notifier).addSong(newSong);
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
