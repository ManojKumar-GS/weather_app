import 'package:flutter/material.dart';
import 'package:weather_app/const/gradient_const.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration:
              BoxDecoration(gradient: GradientConst.gradientBackground.value),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(),
          ),
        ),
      ),
    );
  }
}
