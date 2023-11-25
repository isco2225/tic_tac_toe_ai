import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_xox_app/app/app.dart';
import 'package:flutter_xox_app/app/cubits/theme_color/theme_color_cubit.dart';

void main() {
  runApp(
    BlocProvider(
      create: (context) =>
          ThemeColorCubit(),
      child: const App(),
    ),
  );
}
