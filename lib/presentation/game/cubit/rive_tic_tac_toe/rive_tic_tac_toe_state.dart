part of 'rive_tic_tac_toe_cubit.dart';

class RiveTicTacToeState extends Equatable {
  const RiveTicTacToeState({
  this.readyToMovement,
  this.hasWinner,
  this.openBoard,
  this.box0,
  this.box1,
  this.box2,
  this.box3,
  this.box4,
  this.box5,
  this.box6,
  this.box7,
  this.box8,
  });
  
  final SMIInput<bool>? readyToMovement;
  final SMIInput<double>? hasWinner;
  final SMIInput<bool>? openBoard;
  final SMIInput<double>? box0;
  final SMIInput<double>? box1;
  final SMIInput<double>? box2;
  final SMIInput<double>? box3;
  final SMIInput<double>? box4;
  final SMIInput<double>? box5;
  final SMIInput<double>? box6;
  final SMIInput<double>? box7;
  final SMIInput<double>? box8;

  RiveTicTacToeState copyWith({
    SMIInput<bool>? readyToMovement,
    SMIInput<double>? hasWinner,
    SMIInput<bool>? openBoard,
    SMIInput<double>? box0,
    SMIInput<double>? box1,
    SMIInput<double>? box2,
    SMIInput<double>? box3,
    SMIInput<double>? box4,
    SMIInput<double>? box5,
    SMIInput<double>? box6,
    SMIInput<double>? box7,
    SMIInput<double>? box8,
  }) {
    return RiveTicTacToeState(
      readyToMovement: readyToMovement ?? this.readyToMovement,
      hasWinner: hasWinner ?? this.hasWinner,
      openBoard: openBoard ?? this.openBoard,
      box0: box0 ?? this.box0,
      box1: box1 ?? this.box1,
      box2: box2 ?? this.box2,
      box3: box3 ?? this.box3,
      box4: box4 ?? this.box4,
      box5: box5 ?? this.box5,
      box6: box6 ?? this.box6,
      box7: box7 ?? this.box7,
      box8: box8 ?? this.box8,
    );
  }

  @override
  List<Object?> get props => [
        readyToMovement,
        hasWinner,
        openBoard,
        box0,
        box1,
        box2,
        box3,
        box4,
        box5,
        box6,
        box7,
        box8,
      ];
}
