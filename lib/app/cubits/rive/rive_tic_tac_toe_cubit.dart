import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rive/rive.dart';

part 'rive_tic_tac_toe_state.dart';

class RiveTicTacToeCubit extends Cubit<RiveTicTacToeState> {
  RiveTicTacToeCubit()
      : super(
          const RiveTicTacToeState(),
        );
  
  void initializeValues(StateMachineController boardController) {
    final hasWinner =
        boardController.findInput('hasWinner') as SMIInput<double>?;
    final openBoard = boardController.findInput('openBoard') as SMIInput<bool>?;
    final readyToMovement =
        boardController.findInput('readyToMovement') as SMIInput<bool>?;
    final box0 = boardController.findInput('0') as SMIInput<double>?;
    final box1 = boardController.findInput('1') as SMIInput<double>?;
    final box2 = boardController.findInput('2') as SMIInput<double>?;
    final box3 = boardController.findInput('3') as SMIInput<double>?;
    final box4 = boardController.findInput('4') as SMIInput<double>?;
    final box5 = boardController.findInput('5') as SMIInput<double>?;
    final box6 = boardController.findInput('6') as SMIInput<double>?;
    final box7 = boardController.findInput('7') as SMIInput<double>?;
    final box8 = boardController.findInput('8') as SMIInput<double>?;
    if (_isInputNull([
      hasWinner,
      openBoard,
      readyToMovement,
      box0,
      box1,
      box2,
      box3,
      box4,
      box5,
      box6,
      box7,
      box8,
    ])) {
      return;
    }
    emit(state.copyWith(
      hasWinner: hasWinner,
      openBoard: openBoard,
      readyToMovement: readyToMovement,
      box0: box0,
      box1: box1,
      box2: box2,
      box3: box3,
      box4: box4,
      box5: box5,
      box6: box6,
      box7: box7,
      box8: box8,
    ));
  }

  bool _isInputNull(List<SMIInput?> inputs) {
    bool isInputsNull = false;

    for (final element in inputs) {
      if (element == null) {
        isInputsNull = true;
        break;
      }
    }

    return isInputsNull;
  }
}
