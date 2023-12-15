import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_xox_app/app/cubits/theme_color/theme_color_cubit.dart';
import 'package:flutter_xox_app/presentation/aiLearn/view/game_screen.dart';
import 'package:flutter_xox_app/presentation/game/view/game_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_widgets/shared_widgets.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GradientButton(
            text: '1 vs 1',
            onPressed: () {
              context.goNamed(GameScreen.name);
            },
          ),
          const SizedBox(height: 32),
          GradientButton(
            text: 'Botu Eğit',
            onPressed: () {
              context.goNamed(AiLearnScreen.name);
            },
          ),
          const SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}
