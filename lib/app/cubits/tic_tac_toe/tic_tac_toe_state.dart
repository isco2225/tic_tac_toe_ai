part of 'tic_tac_toe_cubit.dart';

class TicTacToeState extends Equatable {
  const TicTacToeState({
    required this.currentPlayer,
    required this.board,
    required this.roundWinner,
    required this.gameWinner,
    required this.playerOneWinCount,
    required this.playerTwoWinCount,
    required this.emptySquaresIndexes,
    // RIVE
    required this.winLineNumber,
    required this.rematch,
  });

  final int currentPlayer;
  final List<int> board;
  final int? roundWinner;
  final int? gameWinner;
  final int playerOneWinCount;
  final int playerTwoWinCount;
  final List<int> emptySquaresIndexes;

  // RIVE
  final double winLineNumber;
  final bool rematch;

  TicTacToeState copyWith({
    int? currentPlayer,
    List<int>? board,
    int? roundWinner,
    int? gameWinner,
    int? playerOneWinCount,
    int? playerTwoWinCount,
    List<int>? emptySquaresIndexes,
    double? winLineNumber,
    bool? rematch,
  }) {
    return TicTacToeState(
      currentPlayer: currentPlayer ?? this.currentPlayer,
      board: board ?? this.board,
      roundWinner: roundWinner ?? this.roundWinner,
      gameWinner: gameWinner ?? this.gameWinner,
      playerOneWinCount: playerOneWinCount ?? this.playerOneWinCount,
      playerTwoWinCount: playerTwoWinCount ?? this.playerTwoWinCount,
      emptySquaresIndexes: emptySquaresIndexes ?? this.emptySquaresIndexes,
      winLineNumber: winLineNumber ?? this.winLineNumber,
      rematch: rematch ?? this.rematch,
    );
  }

  @override
  List<Object?> get props => [
        currentPlayer,
        board,
        roundWinner,
        gameWinner,
        playerOneWinCount,
        playerTwoWinCount,
        emptySquaresIndexes,
        winLineNumber,
        rematch,
      ];
}
