import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:clases/entities/songs.dart';
import 'package:clases/data/providers.dart'; 

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
              onPressed: () {
                final name = nameController.text.trim();
                final artist = artistController.text.trim();
                final album = albumController.text.trim();
                final cover = coverController.text.trim();
                
                final songList = ref.watch(songsProvider);

                final lastSong = songList[songList.length - 1];
                int newId = lastSong.id + 1;

                final newSong = Song(
                  newId,
                  name,
                  artist,
                  album,
                  cover,
                );

                ref.read(songsProvider.notifier).state = [
                  ...songList,
                  newSong,
                ];

                context.pop();
              },
              child: const Text("Guardar"),
            ),
          ],
        ),
      ),
    );
  }
}
