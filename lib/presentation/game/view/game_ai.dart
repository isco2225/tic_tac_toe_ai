import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_xox_app/app/cubits/tic_tac_toe/tic_tac_toe_cubit.dart';
import 'package:flutter_xox_app/app/cubits/tic_tac_toe_agent/tic_tac_toe_agent_cubit.dart';


class GameAi extends StatelessWidget {
  const GameAi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final ticTacToeGame = context.watch<TicTacToeCubit>().state;

    void aisTurn() async {
      if (ticTacToeGame.currentPlayer != 1) {
        final chosenAction = context.read<TicTacToeAgentCubit>().aksiyonSec(
              ticTacToeGame.emptySquaresIndexes,
              ticTacToeGame.board,
              ticTacToeGame.currentPlayer,
            );

        context.read<TicTacToeCubit>().makeMove(
              emptySquareIndex: chosenAction,
            );

        final durum = context.read<TicTacToeAgentCubit>().tabloAl(
              ticTacToeGame.board,
            );
        context.read<TicTacToeAgentCubit>().durumEkle(durum!, -1);

        final winnerUser = context.read<TicTacToeCubit>().checkWinnerUser();
        if (winnerUser == null) {
          context.read<TicTacToeCubit>().switchPlayer();
        } else {
          context.read<TicTacToeAgentCubit>().feedReward(
                rewardForX: 0,
                rewardForY: 1,
              );
          context.read<TicTacToeAgentCubit>().reset();

          context.read<TicTacToeCubit>().endTheRound(
                winLineNumbers: winnerUser.$2,
                winnerUserIndex: winnerUser.$1,
              );
          final isGameEnded = context.read<TicTacToeCubit>().isGameEnd();
          if (isGameEnded != null) {
            context.read<TicTacToeCubit>().endTheGame(
                  winnerPlayer: winnerUser.$1,
                );
          } else {
            await Future.delayed(const Duration(seconds: 2));
            if (context.mounted) {
              context.read<TicTacToeCubit>().startNewRound();
            }
          }
        }
      }
    }

    if (ticTacToeGame.currentPlayer == -1 &&
        ticTacToeGame.gameWinner == null &&
        ticTacToeGame.winLineNumber == 0) {
      aisTurn();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Oyun Ekranı'),
      ),
      body: Center(
        child: SizedBox(
          width: screenWidth,
          height: screenWidth,
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
            ),
            itemCount: 9,
            itemBuilder: (context, index) {
              return Center(
                child: GestureDetector(
                  onTap: () async {
                    if (ticTacToeGame.currentPlayer != 1) {
                      return;
                    }
                    if (!ticTacToeGame.emptySquaresIndexes.contains(index)) {
                      return;
                    }
                    if (ticTacToeGame.gameWinner != null) {
                      return;
                    }
                    if (ticTacToeGame.winLineNumber != 0) {
                      return;
                    }
                    context.read<TicTacToeCubit>().makeMove(
                          emptySquareIndex: index,
                        );
                    final winnerUser =
                        context.read<TicTacToeCubit>().checkWinnerUser();
                    if (winnerUser == null) {
                      context.read<TicTacToeCubit>().switchPlayer();
                    } else {
                      context.read<TicTacToeAgentCubit>().feedReward(
                            rewardForX: 1,
                            rewardForY: -1,
                          );
                      context.read<TicTacToeAgentCubit>().reset();
                      context.read<TicTacToeCubit>().endTheRound(
                            winLineNumbers: winnerUser.$2,
                            winnerUserIndex: winnerUser.$1,
                          );
                      final isGameEnded =
                          context.read<TicTacToeCubit>().isGameEnd();
                      if (isGameEnded != null) {
                        context.read<TicTacToeCubit>().endTheGame(
                              winnerPlayer: winnerUser.$1,
                            );
                      } else {
                        await Future.delayed(const Duration(seconds: 2));
                        if (context.mounted) {
                          context.read<TicTacToeCubit>().startNewRound();
                        }
                      }
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                    ),
                    width: screenWidth * 0.3,
                    height: screenWidth * 0.3,
                    child: Center(
                      child: Text(
                        (ticTacToeGame.board[index] == 0)
                            ? ''
                            : (ticTacToeGame.board[index] == 1)
                                ? 'X'
                                : 'O',
                        style: const TextStyle(fontSize: 50),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
