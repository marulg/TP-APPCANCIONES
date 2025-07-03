import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:clases/presentation/screens/login_screen.dart';
import 'package:clases/presentation/screens/home_screen.dart';
import 'package:clases/presentation/screens/song_detail.dart';
import 'package:clases/presentation/screens/new_song.dart';
import 'package:clases/presentation/screens/edit_song.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    routes: [
      GoRoute(
        path: '/',
        name: 'login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/home',
        name: 'home',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/songDetail',
        name: 'songDetail',
        builder: (context, state) => const SongDetail(),
      ),
      GoRoute(
        path: '/newSong',
        name: 'newSong',
        builder: (context, state) => NewSongScreen(),
      ),
      GoRoute(
        path: '/editSong',
        name: 'editSong',
        builder: (context, state) => EditSongScreen(),
      ),
    ],
  );
});
