import 'package:flutter/material.dart';

abstract class AppColors {
  // lightPrimaryOne Color Swatch
  static const Color lightPrimaryOne = Color(0xFFFFFFFF);
  // lightSecondary Color Swatch
  static const Color lightSecondary = Color(0xFF4E4E4E);
  // lightOnError Color Swatch
  static const Color lightError = Color(0xFFFF5A5A);
  // lightExampleGradient Color Swatch
  static const List<Color> lightPrimaryGradient = <Color>[
    Color(0xffFFB800),
    Color(0xffFF0099),
  ];

  // darkPrimaryOne Color Swatch
  static const Color darkPrimaryOne = Color(0xFFFFFFFF);
  // darkSecondary Color Swatch
  static const Color darkSecondary = Color(0xFF4E4E4E);
  // darkExampleGradient Color Swatch
  static const List<Color> darkPrimaryGradient = <Color>[
    Color(0xffFFB800),
    Color(0xffFF0099),
  ];
}
