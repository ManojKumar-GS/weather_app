import 'package:flutter/material.dart';

class GradientConst {
  static const List<Color> gradientColor = [
    Colors.blueAccent,
    Colors.grey,
    Colors.orangeAccent
  ];
  static const List<Color> gradientCardColor = [
    Colors.white54,
    Colors.grey,
  ];
  static LinearGradient gradientBackground = const LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      colors: GradientConst.gradientColor);

  static LinearGradient gradientCardBackground = const LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: GradientConst.gradientCardColor);
}
