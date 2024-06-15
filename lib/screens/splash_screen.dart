import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/const/gradient_const.dart';
import 'package:weather_app/screens/base_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(const Duration(seconds: 2), () => Get.off(const BasePage()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration:
            BoxDecoration(gradient: GradientConst.gradientBackground.value),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(CupertinoIcons.cloud_sun_rain, size: 80),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text("Weather Forecast",
                    style:
                        GoogleFonts.notoSansNKo(fontWeight: FontWeight.w900)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
