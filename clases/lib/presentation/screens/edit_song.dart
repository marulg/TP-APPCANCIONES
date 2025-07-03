import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:clases/entities/songs.dart';
import 'package:clases/data/providers.dart'; 

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
              onPressed: () {
                final name = nameController.text.trim();
                final artist = artistController.text.trim();
                final album = albumController.text.trim();
                final cover = coverController.text.trim();
                final id = song.id;

                final newSong = Song(
                  id,
                  name,
                  artist,
                  album,
                  cover,
                );

                final songList = ref.watch(songsProvider);
                final updatedList = [...songList];

                int indexEditedSong = -1;
                for (int i = 0; i < updatedList.length; i++) {
                  if (updatedList[i].id == id) {
                    indexEditedSong = i;
                    break;
                  }
                }
                updatedList[indexEditedSong] = newSong;

                ref.read(songsProvider.notifier).state = updatedList;
                
                context.pop();
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
