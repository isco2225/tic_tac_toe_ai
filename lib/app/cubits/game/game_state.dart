part of 'game_cubit.dart';

class GameState extends Equatable {
  const GameState({
    required this.roundWinner,
    required this.gameWinner,
    required this.board,
    required this.isTurnPlayer1,
    required this.playerOneWinCount,
    required this.playerTwoWinCount,
    required this.winStyleNumber,
    required this.rematch,
  });
//omran alhajhossin
  final List<String> board;
  final String roundWinner;
  final String gameWinner;
  final bool isTurnPlayer1;
  final int playerOneWinCount;
  final int playerTwoWinCount;
  final double winStyleNumber;
  final bool rematch;

  GameState copyWith({
    List<String>? board,
    String? roundWinner,
    String? gameWinner,
    bool? isTurnPlayer1,
    int? playerOneWinCount,
    int? playerTwoWinCount,
    double? winStyleNumber,
    bool? rematch,
  }) {
    return GameState(
      board: board ?? this.board,
      roundWinner: roundWinner ?? this.roundWinner,
      gameWinner: gameWinner ?? this.gameWinner,
      isTurnPlayer1: isTurnPlayer1 ?? this.isTurnPlayer1,
      playerOneWinCount: playerOneWinCount ?? this.playerOneWinCount,
      playerTwoWinCount: playerTwoWinCount ?? this.playerTwoWinCount,
      winStyleNumber: winStyleNumber ?? this.winStyleNumber,
      rematch: rematch ?? this.rematch,
    );
  }

  @override
  List<Object?> get props => [
        board,
        isTurnPlayer1,
        roundWinner,
        gameWinner,
        playerOneWinCount,
        playerTwoWinCount,
        winStyleNumber,
        rematch,
      ];
}
