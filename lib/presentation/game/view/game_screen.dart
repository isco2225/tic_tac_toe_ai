import 'package:flutter/material.dart';
import 'package:flutter_xox_app/presentation/game/view/game_view.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});
  static const String path = "/game";
  static const String name = "game";

  @override
  Widget build(BuildContext context) {
    return const GameView();
  }
}
