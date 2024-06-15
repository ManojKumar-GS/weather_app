import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
  static Rx<LinearGradient> gradientBackground = const LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: GradientConst.gradientColor)
      .obs;
  static Rx<LinearGradient> gradientCardBackground = const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: GradientConst.gradientCardColor)
      .obs;
}
