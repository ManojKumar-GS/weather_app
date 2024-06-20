import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
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
  late Position currentPosition;

  @override
  void initState() {
    getPosition();
    // Timer(const Duration(seconds: 2),
    //     () => Get.off(BasePage(position: currentPosition)));
    super.initState();
  }

  getPosition() async {
    currentPosition = await _determinePosition();
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _determinePosition(),
        builder: (BuildContext context, AsyncSnapshot<Position> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              decoration: BoxDecoration(
                  gradient: GradientConst.gradientBackground.value),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(CupertinoIcons.cloud_sun_rain, size: 80),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text("Weather Forecast",
                          style: GoogleFonts.notoSansNKo(
                              fontWeight: FontWeight.w900)),
                    ),
                  ],
                ),
              ),
            );
          }
          return BasePage(
              latitude: snapshot.data!.latitude,
              longitude: snapshot.data!.longitude);
        },
      ),
    );
  }
}
