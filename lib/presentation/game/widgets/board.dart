import 'package:flame_rive/flame_rive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_xox_app/app/cubits/game/game_cubit.dart';
import 'package:flutter_xox_app/app/gen/assets.gen.dart';

class GameBoard extends StatefulWidget {
  const GameBoard({
    super.key,
  });

  @override
  State<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  late StateMachineController _boardController;

  SMIInput<bool>? readyToMovement;
  SMIInput<double>? hasWinner;
  SMIInput<bool>? openBoard;
  SMIInput<double>? box0;
  SMIInput<double>? box1;
  SMIInput<double>? box2;
  SMIInput<double>? box3;
  SMIInput<double>? box4;
  SMIInput<double>? box5;
  SMIInput<double>? box6;
  SMIInput<double>? box7;
  SMIInput<double>? box8;

  @override
  void dispose() {
    _boardController.dispose();
    super.dispose();
  }

  void onInit(Artboard artboard, double turn) async {
    _boardController = StateMachineController.fromArtboard(
      artboard,
      'State Machine 1',
    )!;
    artboard.addController(_boardController);

    _boardController.addEventListener((riveEvent) {
      final gameState = context.read<GameCubit>().state;
      onRiveEvent(riveEvent, gameState.isTurnPlayer1 ? 1 : 2);
    });

    readyToMovement = _boardController.findInput('readyToMovement');
    hasWinner = _boardController.findInput('hasWinner');
    openBoard = _boardController.findInput('openBoard');
    box0 = _boardController.findInput('box0Value');
    box1 = _boardController.findInput('box1Value');
    box2 = _boardController.findInput('box2Value');
    box3 = _boardController.findInput('box3Value');
    box4 = _boardController.findInput('box4Value');
    box5 = _boardController.findInput('box5Value');
    box6 = _boardController.findInput('box6Value');
    box7 = _boardController.findInput('box7Value');
    box8 = _boardController.findInput('box8Value');
  }

  void onRiveEvent(RiveEvent event, double turn) {
    if (context.read<GameCubit>().state.gameWinner != '') {
      return;
    }
    if (event.name == 'introlEnded') {
      openBoard?.change(true);
    } else if (event.name == 'onBoardOpen') {
      hasWinner?.change(0);
      readyToMovement?.change(true);
    } else if (event.name == 'onBoardClosed') {
      if (context.read<GameCubit>().state.playerOneWinCount != 3 &&
          context.read<GameCubit>().state.playerTwoWinCount != 3) {
        hasWinner?.change(0);
        openBoard?.change(true);
      }
      context.read<GameCubit>().gameOver();
    } else if ((event.name == 'box0' ||
            event.name == 'box1' ||
            event.name == 'box2' ||
            event.name == 'box3' ||
            event.name == 'box4' ||
            event.name == 'box5' ||
            event.name == 'box6' ||
            event.name == 'box7' ||
            event.name == 'box8') &&
        (readyToMovement?.value ?? false)) {
      int? clickedBox = detectEventBox(event.name);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (clickedBox != null) {
          movement(clickedBox, turn);
        }
      });
    } else if (event.name == 'onMovementEnd') {
      if (context.read<GameCubit>().state.roundWinner == '') {
        readyToMovement?.change(true);
      } else {
        hasWinner?.change(context.read<GameCubit>().state.winStyleNumber);
      }
    } else if (event.name == 'roundEnd') {
      context.read<GameCubit>().resetBoard();
      // todo: Kutu içleri animasyonsuz gidiyor.
      clearBoxes();
      openBoard?.change(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final gameState = context.watch<GameCubit>().state;
    if (gameState.rematch == true) {
      hasWinner?.change(0);
      openBoard?.change(true);
      context.read<GameCubit>().restartGame();
    }
    return RiveAnimation.asset(
      Assets.animations.ticTacToe.path,
      stateMachines: const ['State Machine 1'],
      onInit: (artBoard) {
        onInit(
          artBoard,
          gameState.isTurnPlayer1 ? 1 : 2,
        );
      },
    );
  }

  int? detectEventBox(String name) {
    return switch (name) {
      'box0' => 0,
      'box1' => 1,
      'box2' => 2,
      'box3' => 3,
      'box4' => 4,
      'box5' => 5,
      'box6' => 6,
      'box7' => 7,
      'box8' => 8,
      _ => null,
    };
  }

  void movement(int clickedBoxIndex, double turnIndex) {
    void playOnCubit() {
      context.read<GameCubit>().playerMovement(clickedBoxIndex);
    }

    switch (clickedBoxIndex) {
      case 0:
        box0?.change(turnIndex);
        playOnCubit();
        readyToMovement?.change(false);
        break;
      case 1:
        box1?.change(turnIndex);
        playOnCubit();
        readyToMovement?.change(false);
        break;
      case 2:
        box2?.change(turnIndex);
        playOnCubit();
        readyToMovement?.change(false);
        break;
      case 3:
        box3?.change(turnIndex);
        playOnCubit();
        readyToMovement?.change(false);
        break;
      case 4:
        box4?.change(turnIndex);
        playOnCubit();
        readyToMovement?.change(false);
        break;
      case 5:
        box5?.change(turnIndex);
        playOnCubit();
        break;
      case 6:
        box6?.change(turnIndex);
        playOnCubit();
        readyToMovement?.change(false);
        break;
      case 7:
        box7?.change(turnIndex);
        playOnCubit();
        readyToMovement?.change(false);
        break;
      case 8:
        box8?.change(turnIndex);
        playOnCubit();
        readyToMovement?.change(false);
        break;
      default:
        break;
    }
  }

  void clearBoxes() {
    box0?.change(0);
    box1?.change(0);
    box2?.change(0);
    box3?.change(0);
    box4?.change(0);
    box5?.change(0);
    box6?.change(0);
    box7?.change(0);
    box8?.change(0);
  }
}
