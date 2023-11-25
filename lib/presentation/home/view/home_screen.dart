import 'package:flutter/material.dart';
import 'package:flutter_xox_app/presentation/home/view/view.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static const String path = "/home";
  static const String name = "home";

  @override
  Widget build(BuildContext context) {
    return const HomeView();
  }
}
