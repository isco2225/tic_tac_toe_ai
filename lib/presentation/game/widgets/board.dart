import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_xox_app/app/cubits/game/game.dart';

class GameBoard extends StatefulWidget {
  const GameBoard({
    super.key,
  });

  @override
  State<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  List<String> board = ['', '', '', '', '', '', '', '', ''];
  String winner = '';

  bool isTurnO = false;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: 9,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
      ),
      itemBuilder: (BuildContext context, int index) {
        final state = context.watch<GameCubit>().state;
        final inBoard = state.board[index];

        return GestureDetector(
          onTap: () {
            if (state.roundWinner != '') {
              return;
            }
            context.read<GameCubit>().playerMovement(index);
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                width: 3,
                color: Colors.red,
              ),
              color: Colors.grey,
            ),
            child: Center(
              child: Text(
                inBoard,
                style: const TextStyle(
                  fontSize: 70,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
