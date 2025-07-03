import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:clases/core/router/app_router.dart'; 

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GoRouter appRouter = ref.watch(appRouterProvider);

    return MaterialApp.router(
      title: 'Mis canciones',
      theme: ThemeData.light(), 
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system, 
      routerConfig: appRouter, 
    );
  }
}
