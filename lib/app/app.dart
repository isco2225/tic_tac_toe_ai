import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_xox_app/app/cubits/game/game.dart';
import 'package:flutter_xox_app/app/cubits/theme_color/theme_color.dart';
import 'package:flutter_xox_app/app/cubits/theme_color/theme_color_state.dart';
import 'package:flutter_xox_app/app/cubits/tic_tac_toe/tic_tac_toe_cubit.dart';
import 'package:flutter_xox_app/app/cubits/tic_tac_toe_agent/tic_tac_toe_agent_cubit.dart';
import 'package:flutter_xox_app/app/router/app_router.dart';
import 'package:flutter_xox_app/app/theme/app_themes.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> with RouterMixin {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => GameCubit(),
        ),
        BlocProvider(create: 
        (context) => TicTacToeCubit(),
        ),
         BlocProvider(create: 
        (context) => TicTacToeAgentCubit(),
        ),
        
      ],
      child: BlocBuilder<ThemeColorCubit, ThemeColorState>(
        builder: (context, state) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme, // default theme.
            darkTheme: AppTheme.darkTheme,
            themeMode:
                context.read<ThemeColorCubit>().state.isThemeLight == true
                    ? ThemeMode.light
                    : ThemeMode.dark, // Mod ayarı
            routerConfig: router,
            builder: (context, child) {
              return child!;
            },
          );
        },
      ),
    );
  }
}
