import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'tic_tac_toe_state.dart';

class TicTacToeCubit extends Cubit<TicTacToeState> {
  TicTacToeCubit()
      : super(
          const TicTacToeState(
            currentPlayer: 1,
            board: [0, 0, 0, 0, 0, 0, 0, 0, 0],
            roundWinner: null,
            gameWinner: null,
            playerOneWinCount: 0,
            playerTwoWinCount: 0,
            winLineNumber: 0,
            rematch: false,
            emptySquaresIndexes: [0, 1, 2, 3, 4, 5, 6, 7, 8],
          ),
        );
  void rematch() {
    emit(state.copyWith(rematch: true));
  }

  void startNewGame() {
    emit(const TicTacToeState(
      currentPlayer: 1,
      board: [0, 0, 0, 0, 0, 0, 0, 0, 0],
      roundWinner: null,
      gameWinner: null,
      emptySquaresIndexes: [0, 1, 2, 3, 4, 5, 6, 7, 8],
      playerOneWinCount: 0,
      playerTwoWinCount: 0,
      // RIVE
      winLineNumber: 0,
      rematch: false,
    ));
  }

  void makeMove({required int emptySquareIndex}) {
    if (state.emptySquaresIndexes.contains(emptySquareIndex)) {
      final holdBoard = List<int>.from(state.board);
      final holdEmptySquares = List<int>.from(state.emptySquaresIndexes);

      holdBoard[emptySquareIndex] = state.currentPlayer;
      holdEmptySquares.remove(emptySquareIndex);
      emit(state.copyWith(
        board: holdBoard,
        emptySquaresIndexes: holdEmptySquares,
      ));
    }
  }

  (int winnerPlayer, List<int> winLineNumbers)? checkWinnerUser() {
    List<List<int>> lines = [
      [0, 1, 2], [3, 4, 5], [6, 7, 8], // Rows
      [0, 3, 6], [1, 4, 7], [2, 5, 8], // Columns
      [0, 4, 8], [2, 4, 6] // Diagonals
    ];

    for (List<int> line in lines) {
      int sum = line.map((index) => state.board[index]).reduce((a, b) => a + b);
      if (sum == 3 || sum == -3) {
        return (sum ~/ 3, line);
      }
    }

    if (state.roundWinner == null && state.emptySquaresIndexes.isEmpty) {
      return (0, [0, 0, 0]);
    }
    return null;
  }

  // checkWinnerUser == null
  void switchPlayer() {
    final newCurrentPlayer = (state.currentPlayer == 1) ? -1 : 1;
    emit(state.copyWith(currentPlayer: newCurrentPlayer));
  }

  // checkWinnerUser != null
  void endTheRound({
    required winnerUserIndex,
    required List<int> winLineNumbers,
  }) {
    double winLineNumber = int.parse(winLineNumbers.join('')).toDouble();
    if (winnerUserIndex == 1) {
      emit(state.copyWith(
        playerOneWinCount: state.playerOneWinCount + 1,
        winLineNumber: winLineNumber,
        roundWinner: 1,
      ));
    }
    if (winnerUserIndex == -1) {
      emit(state.copyWith(
        playerTwoWinCount: state.playerTwoWinCount + 1,
        winLineNumber: winLineNumber,
        roundWinner: 2,
      ));
    }
  }

  int? isGameEnd() {
    if (state.playerOneWinCount == 3) {
      return 1;
    }
    if (state.playerTwoWinCount == 3) {
      return -1;
    }
    return null;
  }

  // isGameEnd == null
  void startNewRound() {
    emit(TicTacToeState(
      currentPlayer: 1,
      board: const [0, 0, 0, 0, 0, 0, 0, 0, 0],
      roundWinner: null,
      gameWinner: null,
      emptySquaresIndexes: const [0, 1, 2, 3, 4, 5, 6, 7, 8],
      winLineNumber: 0,
      playerOneWinCount: state.playerOneWinCount,
      playerTwoWinCount: state.playerTwoWinCount,
      rematch: state.rematch,
    ));
  }

  // isGameEnd != null
  void endTheGame({required int winnerPlayer}) {
    emit(state.copyWith(
      gameWinner: winnerPlayer,
    ));
  }
}
