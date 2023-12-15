import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_xox_app/app/cubits/game/game_cubit.dart';
import 'package:flutter_xox_app/presentation/game/view/tic_tac_toe_game.dart';
import 'package:flutter_xox_app/presentation/home/home.dart';
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
              context.read<GameCubit>().restartGame();
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
