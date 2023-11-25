import 'package:flutter/material.dart';
import 'package:flutter_xox_app/app/theme/app_colors.dart';

class AppTheme {
  static final darkTheme = ThemeData.dark().copyWith(
    appBarTheme: const AppBarTheme(centerTitle: true),
    colorScheme: const ColorScheme.dark(),
    scaffoldBackgroundColor: AppColors.darkSecondary,
  );

  static final lightTheme = ThemeData.light().copyWith(
    appBarTheme: const AppBarTheme(centerTitle: true),
    colorScheme: const ColorScheme.light(),
    scaffoldBackgroundColor: AppColors.lightPrimaryOne,
  );
}
