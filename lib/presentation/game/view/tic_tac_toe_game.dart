import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_xox_app/app/cubits/game/game.dart';
import 'package:flutter_xox_app/presentation/game/widgets/board.dart';
import 'package:shared_constants/shared_constants.dart';
import 'package:shared_widgets/shared_widgets.dart';
class TicTacToeGame extends StatefulWidget {
  const TicTacToeGame({super.key});

  @override
  State<TicTacToeGame> createState() => _TicTacToeGameState();
}

class _TicTacToeGameState extends State<TicTacToeGame> {
  @override
  Widget build(BuildContext context) {
    final gameState = context.watch<GameCubit>().state;

    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    AnimatedOpacity(
                      opacity: !gameState.isTurnPlayer1 ? 0.5 : 1,
                      duration: SharedDurations.ms370,
                      child: Text(
                        '1.oyuncu ${gameState.playerOneWinCount}',
                        style: const TextStyle(
                          fontSize: 24,
                          color: Colors.redAccent,
                        ),
                      ),
                    ),
                    AnimatedOpacity(
                      opacity: gameState.isTurnPlayer1 ? 0.5 : 1,
                      duration: SharedDurations.ms370,
                      child: Text(
                        '2.oyuncu ${gameState.playerTwoWinCount}',
                        style: const TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Expanded(
                flex: 5,
                child: GameBoard(),
              ),
              gameState.roundWinner == ''
                  ? const SizedBox()
                  : Text(
                      'Kazanan: ${gameState.roundWinner}',
                      style: const TextStyle(fontSize: 30, color: Colors.amber),
                    ),
            ],
          ),
        ),
        if (gameState.gameWinner != '')
          Animate(
            effects: const [
              FadeEffect(duration: SharedDurations.ms200),
              ScaleEffect(duration: SharedDurations.ms200),
            ],
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              icon: const Icon(Icons.play_arrow),
              title: Text('Kazanan Oyuncu: ${gameState.gameWinner}'),
              actions: [
                GradientButton(
                  text: 'Tekrar Oyna',
                  onPressed: () {
                    context.read<GameCubit>().rematch();
                  },
                ),
              ],
            ),
          ),
      ],
    );
  }
}
