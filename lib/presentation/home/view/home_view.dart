import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_xox_app/app/cubits/theme_color/theme_color_cubit.dart';
import 'package:flutter_xox_app/presentation/game/view/game_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_widgets/shared_widgets.dart';
import 'package:rive/rive.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

StateMachineController? controller;
SMIInput<double>? inputValue;

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: context.read<ThemeColorCubit>().changeThemeColor,
          icon: const Icon(Icons.light),
        ),
        title: Title(
          color: Colors.black,
          child: const Text('data'),
        ),
      ),
      body: BaseColumn(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          /* ,*/
          SizedBox(
            height: 320,
            width: 320,
            child: RiveAnimation.asset(
              'assets/animations/rating_animation.riv',
              onInit: (art) {
                controller =
                    StateMachineController.fromArtboard(art, 'State Machine 1');
                if (controller != null) {
                  art.addController(controller!);
                  inputValue = controller?.findInput('rating');
                  inputValue?.change(0);
                }
              },
            ),
          ),
          GradientButton(
            text: '1 vs 1',
            onPressed: () {
              context.goNamed(GameScreen.name);
            },
          ),
          GradientButton(
            text: '1 vs AI',
            onPressed: () {},
          ),
          GradientButton(
            text: 'AI vs AI',
            onPressed: () {},
          ),
          const SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}
