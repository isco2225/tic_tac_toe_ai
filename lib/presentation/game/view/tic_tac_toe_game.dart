import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_xox_app/app/cubits/game/game.dart';
import 'package:flutter_xox_app/presentation/game/widgets/board.dart';
import 'package:shared_constants/shared_constants.dart';
import 'package:shared_widgets/shared_widgets.dart';

/*class TicTacToeGame extends FlameGame {
  @override
  FutureOr<void> onLoad() async {
    await add(
      HatayiYasatText(
        text: 'I',
        position: Vector2(size.x / 2, size.y - 30),
      ),
    );
    // TODO: implement onLoad
    return super.onLoad();
  }
}

class HatayiYasatText extends TextComponent
    with TapCallbacks, HasGameReference<TicTacToeGame> {
  HatayiYasatText({required String text, required Vector2 position}) {
    this.text = text;
    this.position = position;
    anchor = Anchor.center;
  }
  bool isJumping = false;
  @override
  void onTapDown(TapDownEvent event) async {
    jump();
    // TODO: implement onTapDown
    super.onTapDown(event);
  }

  @override
  void update(double dt) {
    if (position.y <= game.size.y - 30) {
      print('ucuyo hatay');
      position = Vector2(position.x, position.y + 0.5);
    }
    if (isJumping) {
      position = Vector2(position.x, position.y - 1.5);
    }
    // TODO: implement update
    super.update(dt);
  }

  void jump() async {
    isJumping = true;
    await Future.delayed(
      const Duration(milliseconds: 500),
    );
    isJumping = false;
  }
}*/
class TicTacToeGame extends StatefulWidget {
  const TicTacToeGame({super.key});

  @override
  State<TicTacToeGame> createState() => _TicTacToeGameState();
}

class _TicTacToeGameState extends State<TicTacToeGame> {
  @override
  Widget build(BuildContext context) {
    final gameState = context.watch<GameCubit>().state;

    return gameState.gameWinner == ''
        ? Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      AnimatedOpacity(
                        opacity: !gameState.isTurnPlayer1 ? 0.5 : 1,
                        duration: SharedDurations.ms370,
                        child: Text(
                          '1.oyuncu ${gameState.playerOneWinCount}',
                          style: const TextStyle(
                            fontSize: 24,
                            color: Colors.redAccent,
                          ),
                        ),
                      ),
                      AnimatedOpacity(
                        opacity: gameState.isTurnPlayer1 ? 0.5 : 1,
                        duration: SharedDurations.ms370,
                        child: Text(
                          '2.oyuncu ${gameState.playerTwoWinCount}',
                          style: const TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Expanded(
                  flex: 5,
                  child: GameBoard(),
                ),
                gameState.roundWinner == ''
                    ? const SizedBox()
                    : Text(
                        'Kazanan: ${gameState.roundWinner}',
                        style:
                            const TextStyle(fontSize: 30, color: Colors.amber),
                      ),
              ],
            ),
          )
        : AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            icon: const Icon(Icons.play_arrow),
            title: Text('Kazanan Oyuncu: ${gameState.gameWinner}'),
            actions: [
              GradientButton(
                text: 'Tekrar Oyna',
                onPressed: () {
                  context.read<GameCubit>().restartGame();
                },
              ),
            ],
          );
  }
}
