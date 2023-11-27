import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'game_state.dart';

class GameCubit extends Cubit<GameState> {
  GameCubit()
      : super(
          const GameState(
            isTurnPlayer1: true,
            board: ['', '', '', '', '', '', '', '', ''],
            roundWinner: '',
            gameWinner: '',
            playerOneWinCount: 0,
            playerTwoWinCount: 0,
            winStyleNumber: 0,
            rematch: false,
          ),
        );
  void restartGame() {
    emit(
      const GameState(
        isTurnPlayer1: true,
        board: ['', '', '', '', '', '', '', '', ''],
        roundWinner: '',
        gameWinner: '',
        playerOneWinCount: 0,
        playerTwoWinCount: 0,
        winStyleNumber: 0,
        rematch: false,
      ),
    );
  }

  void playerMovement(int index) {
    if (state.board[index] != '') {
      return;
    }
    List<String> updatedBoard = state.board.toList();

    if (state.isTurnPlayer1) {
      updatedBoard[index] = 'X';
      if (_checkWinner(updatedBoard) == 'X') {
        emit(
          state.copyWith(
            board: updatedBoard,
            isTurnPlayer1: false,
            playerOneWinCount: state.playerOneWinCount + 1,
            roundWinner: 'X',
          ),
        );
      } else {
        emit(
          state.copyWith(
            board: updatedBoard,
            isTurnPlayer1: false,
          ),
        );
      }
    } else if (!state.isTurnPlayer1) {
      updatedBoard[index] = 'O';
      if (_checkWinner(updatedBoard) == 'O') {
        emit(
          state.copyWith(
            board: updatedBoard,
            isTurnPlayer1: true,
            playerTwoWinCount: state.playerTwoWinCount + 1,
            roundWinner: 'O',
          ),
        );
      } else {
        emit(
          state.copyWith(
            board: updatedBoard,
            isTurnPlayer1: true,
          ),
        );
      }
    }
    if (!updatedBoard.contains('') && state.roundWinner == '') {
      emit(
        state.copyWith(
          roundWinner: 'Berabere',
        ),
      );
    }

    // Call AI player move after the human player's move
  }

  Future<void> resetBoard() async {
    if (state.gameWinner != '') {
      return;
    }
    emit(
      state.copyWith(
        board: ['', '', '', '', '', '', '', '', ''],
        roundWinner: '',
        winStyleNumber: 0,
      ),
    );
  }

  void rematch() {
    emit(state.copyWith(
      rematch: true,
    ));
  }

  String _checkWinner(List<String> board) {
    String winner = '';
    if (winner == '') {
      winner = _checkRows(board);
    }
    if (winner == '') {
      winner = _checkColumns(board);
    }
    if (winner == '') {
      winner = _checkCrosses(board);
    }

    return winner;
  }

  void gameOver() {
    if (state.playerOneWinCount == 3) {
      emit(
        state.copyWith(
          playerOneWinCount: 0,
          playerTwoWinCount: 0,
          gameWinner: '1. Oyuncu',
          isTurnPlayer1: true,
        ),
      );
    } else if (state.playerTwoWinCount == 3) {
      emit(
        state.copyWith(
          playerOneWinCount: 0,
          playerTwoWinCount: 0,
          gameWinner: '2. Oyuncu',
          isTurnPlayer1: true,
        ),
      );
    }
  }

  String _checkRows(List<String> board) {
    if (board[0] == board[1] && board[0] == board[2] && board[0] != '') {
      emit(state.copyWith(winStyleNumber: 012));

      return board[0];
    }

    if (board[3] == board[4] && board[3] == board[5] && board[3] != '') {
      emit(state.copyWith(winStyleNumber: 345));
      return board[3];
    }

    if (board[6] == board[7] && board[6] == board[8] && board[6] != '') {
      emit(state.copyWith(winStyleNumber: 678));
      return board[6];
    }
    return '';
  }

  String _checkColumns(List<String> board) {
    if (board[0] == board[3] && board[0] == board[6] && board[0] != '') {
      emit(state.copyWith(winStyleNumber: 036));
      return board[0];
    }

    if (board[1] == board[4] && board[1] == board[7] && board[1] != '') {
      emit(state.copyWith(winStyleNumber: 147));
      return board[1];
    }

    if (board[2] == board[5] && board[2] == board[8] && board[2] != '') {
      emit(state.copyWith(winStyleNumber: 258));
      return board[2];
    }
    return '';
  }

  String _checkCrosses(List<String> board) {
    if (board[4] == '') {
      return '';
    }
    if (board[2] == board[4] && board[4] == board[6]) {
      emit(state.copyWith(winStyleNumber: 246));
      return board[4];
    }

    if (board[0] == board[8] && board[8] == board[4]) {
      emit(state.copyWith(winStyleNumber: 048));
      return board[4];
    }
    return '';
  }
}
