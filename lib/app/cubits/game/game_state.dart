part of 'game_cubit.dart';

class GameState extends Equatable {
  const GameState({
    required this.roundWinner,
    required this.gameWinner,
    required this.board,
    required this.isTurnPlayer1,
    required this.playerOneWinCount,
    required this.playerTwoWinCount,
  });

  final List<String> board;
  final String roundWinner;
  final String gameWinner;
  final bool isTurnPlayer1;
  final int playerOneWinCount;
  final int playerTwoWinCount;

  GameState copyWith({
    List<String>? board,
    String? winner,
    String? gameWinner,
    bool? isTurnPlayer1,
    int? playerOneWinCount,
    int? playerTwoWinCount,
  }) {
    return GameState(
      board: board ?? this.board,
      roundWinner: winner ?? this.roundWinner,
      gameWinner: gameWinner ?? this.gameWinner,
      isTurnPlayer1: isTurnPlayer1 ?? this.isTurnPlayer1,
      playerOneWinCount: playerOneWinCount ?? this.playerOneWinCount,
      playerTwoWinCount: playerTwoWinCount ?? this.playerTwoWinCount,
    );
  }

  @override
  List<Object?> get props => [
        board,
        isTurnPlayer1,
        roundWinner,
        playerOneWinCount,
        playerTwoWinCount,
      ];
}
