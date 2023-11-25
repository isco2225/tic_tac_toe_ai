import 'package:flutter/material.dart';
import 'package:flutter_xox_app/app/app.dart';
import 'package:flutter_xox_app/presentation/game/view/game_screen.dart';
import 'package:flutter_xox_app/presentation/home/view/view.dart';
import 'package:go_router/go_router.dart';

mixin RouterMixin on State<App> {
  final _router = GoRouter(
    initialLocation: HomeScreen.path,
    routes: [
      GoRoute(
        path: HomeScreen.path,
        name: HomeScreen.name,
        pageBuilder: (context, state) {
          return const NoTransitionPage(
            child: HomeScreen(),
          );
        },
      ),
      GoRoute(
        path: GameScreen.path,
        name: GameScreen.name,
        pageBuilder: (context, state) {
          return const NoTransitionPage(
            child: GameScreen(),
          );
        },
      ),
    ],
  );
  GoRouter get router => _router;
}
