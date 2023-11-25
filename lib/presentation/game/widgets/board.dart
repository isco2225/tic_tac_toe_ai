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
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  late StateMachineController _boardController;
  SMIInput<double>? box0;
  SMIInput<double>? box1;
  SMIInput<double>? box2;
  SMIInput<double>? box3;
  SMIInput<double>? box4;
  SMIInput<double>? box5;
  SMIInput<double>? box6;
  SMIInput<double>? box7;
  SMIInput<double>? box8;

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

    box0 = _boardController.findInput('0');
    box1 = _boardController.findInput('1');
    box2 = _boardController.findInput('2');
    box3 = _boardController.findInput('3');
    box4 = _boardController.findInput('4');
    box5 = _boardController.findInput('5');
    box6 = _boardController.findInput('6');
    box7 = _boardController.findInput('7');
    box8 = _boardController.findInput('8');
  }

  void onRiveEvent(RiveEvent event, double turn) {
    int? clickedBox = detectEventBox(event.name);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (clickedBox != null) {
        movement(clickedBox, turn);
      }
    });
  }

  // DELETABLE
  // List<String> board = ['', '', '', '', '', '', '', '', ''];
  // String winner = '';

  // bool isTurnO = false;

  @override
  Widget build(BuildContext context) {
    final gameState = context.watch<GameCubit>().state;

    return RiveAnimation.asset(
      Assets.animations.ticTacToeBoard.path,
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
        break;
      case 1:
        box1?.change(turnIndex);
        playOnCubit();
        break;
      case 2:
        box2?.change(turnIndex);
        playOnCubit();
        break;
      case 3:
        box3?.change(turnIndex);
        playOnCubit();
        break;
      case 4:
        box4?.change(turnIndex);
        playOnCubit();
        break;
      case 5:
        box5?.change(turnIndex);
        playOnCubit();
        break;
      case 6:
        box6?.change(turnIndex);
        playOnCubit();
        break;
      case 7:
        box7?.change(turnIndex);
        playOnCubit();
        break;
      case 8:
        box8?.change(turnIndex);
        playOnCubit();
        break;
      default:
        break;
    }
  }
}
