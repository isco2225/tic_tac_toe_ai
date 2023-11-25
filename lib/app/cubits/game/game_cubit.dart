import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_constants/shared_constants.dart';

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
            winner: 'X',
          ),
        );
        _gameOwer();
        _resetBoard();
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
            winner: 'O',
          ),
        );
        _gameOwer();
        _resetBoard();
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
          winner: 'Berabere',
        ),
      );
      _resetBoard();
    }

    // Call AI player move after the human player's move
  }

  Future<void> _resetBoard() async {
    await Future.delayed(SharedDurations.s2);
    emit(
      state.copyWith(board: ['', '', '', '', '', '', '', '', ''], winner: ''),
    );
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
    print(board);

    return winner;
  }

  void _gameOwer() {
    if (state.playerOneWinCount == 3) {
      print('game Ower');
      emit(
        state.copyWith(
          playerOneWinCount: 0,
          playerTwoWinCount: 0,
          gameWinner: '1. Oyuncu',
          isTurnPlayer1: true,
        ),
      );
    } else if (state.playerTwoWinCount == 3) {
      print('game Ower');
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
      return board[0];
    }

    if (board[3] == board[4] && board[3] == board[5] && board[3] != '') {
      return board[3];
    }

    if (board[6] == board[7] && board[6] == board[8] && board[6] != '') {
      return board[6];
    }
    return '';
  }

  String _checkColumns(List<String> board) {
    if (board[0] == board[3] && board[0] == board[6] && board[0] != '') {
      return board[0];
    }

    if (board[1] == board[4] && board[1] == board[7] && board[1] != '') {
      return board[1];
    }

    if (board[2] == board[5] && board[2] == board[8] && board[2] != '') {
      return board[2];
    }
    return '';
  }

  String _checkCrosses(List<String> board) {
    if (board[4] == '') {
      return '';
    }
    if (board[2] == board[4] && board[4] == board[6]) {
      return board[4];
    }

    if (board[0] == board[8] && board[8] == board[4]) {
      return board[4];
    }
    return '';
  }
}