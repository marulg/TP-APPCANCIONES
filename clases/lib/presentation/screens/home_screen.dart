import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:clases/data/providers.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final songList = ref.watch(songsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Lista de Canciones')),
      body: ListView.builder(
        itemCount: songList.length,
        itemBuilder: (context, index) {
          final song = songList[index];
          return ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                song.cover,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.music_note),
              ),
            ),
            title: Text('${song.name} · ${song.artist}'),
            subtitle: Text(song.album),
            onTap: () {
              ref.read(selectedSongProvider.notifier).state = song;
              context.pushNamed('songDetail');
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.pushNamed('newSong');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
