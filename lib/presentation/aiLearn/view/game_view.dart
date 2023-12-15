import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_xox_app/app/cubits/tic_tac_toe/tic_tac_toe_cubit.dart';
import 'package:flutter_xox_app/app/cubits/tic_tac_toe_agent/tic_tac_toe_agent_cubit.dart';
import 'package:flutter_xox_app/presentation/home/home.dart';
import 'package:go_router/go_router.dart';

class AiLearnView extends StatefulWidget {
  const AiLearnView({super.key});

  @override
  State<AiLearnView> createState() => _AiLearnViewState();
}

class _AiLearnViewState extends State<AiLearnView> {
  bool isAgentInTraining = false;
  int secondsElapsed = 0;
  late Timer trainingTimer;
  void startTrainingTimer() {
    trainingTimer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      setState(() {
        secondsElapsed++;
      });
    });
  }

  void stopTrainingTimer() {
    trainingTimer.cancel();
  }

  @override
  void dispose() {
    trainingTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final agentState = context.watch<TicTacToeAgentCubit>().state;
    final ticTacToeGame = context.watch<TicTacToeCubit>().state;
    void aisTurn() {
      final choosenAction = context.read<TicTacToeAgentCubit>().aksiyonSec(
            ticTacToeGame.emptySquaresIndexes,
            ticTacToeGame.board,
            ticTacToeGame.currentPlayer,
          );
      // BOT OYNUYO
      context.read<TicTacToeCubit>().makeMove(
            emptySquareIndex: choosenAction,
          );
      // BOT OYNUYO
      final durum = context.read<TicTacToeAgentCubit>().tabloAl(
            ticTacToeGame.board,
          );
      context.read<TicTacToeAgentCubit>().durumEkle(
            durum!,
            ticTacToeGame.currentPlayer,
          );

      final winnerUser = context.read<TicTacToeCubit>().checkWinnerUser();
      if (winnerUser == null) {
        context.read<TicTacToeCubit>().switchPlayer();
      } else {
        double rewardForX = winnerUser.$1 == 1
            ? 1
            : winnerUser.$1 == -1
                ? -1
                : 0.2;
        double rewardForY = winnerUser.$1 == -1
            ? 1
            : winnerUser.$1 == 1
                ? -1
                : 0.2;
        context.read<TicTacToeAgentCubit>().feedReward(
              rewardForX: rewardForX,
              rewardForY: rewardForY,
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
          if (context.mounted) {
            context.read<TicTacToeCubit>().startNewRound();
          }
        }
      }
    }

    if (isAgentInTraining) {
      aisTurn();
    }
    final screenWidth = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  icon: const Icon(Icons.timer),
                  content: Text('Eğitim Süresi $secondsElapsed saniye'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(); // AlertDialog'ı kapat
                        context.goNamed(HomeScreen.name);
                      },
                      child: const Text('Tamam'),
                    ),
                  ],
                );
              },
            );

            // context.read<TicTacToeAgentCubit>().reset();
            context.goNamed(HomeScreen.name);
          },
        ),
        title: const Text('Yapay Zeka Eğitimi'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Center(
              child: Text('Agent X QTable'),
            ),
            Center(
              child: SizedBox(
                height: 200,
                child: Text(agentState.qTableForX.toString()),
              ),
            ),
            const Center(
              child: Text('Agent O QTable'),
            ),
            Center(
              child: SizedBox(
                height: 200,
                child: Text(agentState.qTableForY.toString()),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (isAgentInTraining) {
                  stopTrainingTimer();
                } else {
                  startTrainingTimer();
                }

                isAgentInTraining = !isAgentInTraining;
                setState(() {});
              },
              child: isAgentInTraining
                  ? const Text('Eğitimi Durdur')
                  : const Text('Eğitimi Başlat'),
            ),
          ],
        ),
      ),
    );
  }
}
