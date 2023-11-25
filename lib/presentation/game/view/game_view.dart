import 'package:flutter/material.dart';
import 'package:flutter_xox_app/presentation/game/view/tic_tac_toe_game.dart';
import 'package:flutter_xox_app/presentation/home/game.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_widgets/shared_widgets.dart';

class GameView extends StatelessWidget {
  const GameView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              context.goNamed(HomeScreen.name);
            },
            icon: const Icon(Icons.exit_to_app_outlined),
          ),
        ],
        title: Title(
          color: Colors.black,
          child: const Text('Oyun ekranı'),
        ),
      ),
      body: const Stack(
        children: [
          TicTacToeGame(),
        ],
      ),
    );
  }
}
