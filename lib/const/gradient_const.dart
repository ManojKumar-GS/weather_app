import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GradientConst {
  static const List<Color> gradientColor = [
    Colors.blueAccent,
    Colors.grey,
    Colors.orangeAccent
  ];
  static Rx<LinearGradient> gradientBackground = const LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: GradientConst.gradientColor)
      .obs;
}
