import 'package:flutter/material.dart';
import 'package:flutter_xox_app/presentation/aiLearn/view/learn_view.dart';

class AiLearnScreen extends StatelessWidget {
  const AiLearnScreen({super.key});
  static const String path = "/aiLearn";
  static const String name = "aiLearn";

  @override
  Widget build(BuildContext context) {
    return const AiLearnView();
  }
}
