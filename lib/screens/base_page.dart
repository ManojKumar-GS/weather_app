import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/const/gradient_const.dart';
import 'package:weather_app/screens/home_screen.dart';
import 'package:weather_app/screens/search_screen.dart';

class BasePage extends StatefulWidget {
  final double latitude;
  final double longitude;
  const BasePage({super.key, required this.latitude, required this.longitude});

  @override
  State<BasePage> createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  int selectedIndex = 0;
  List screens = [];

  @override
  void initState() {
    getScreens();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration:
            BoxDecoration(gradient: GradientConst.gradientBackground.value),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: screens[selectedIndex],
          bottomNavigationBar: Theme(
            data: ThemeData(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
            ),
            child: BottomNavigationBar(
              iconSize: 40,
              elevation: 0,
              selectedItemColor: Colors.black,
              selectedIconTheme:
                  const IconThemeData(color: Colors.black, size: 50),
              selectedLabelStyle: GoogleFonts.akshar(
                  color: Colors.deepPurpleAccent, fontWeight: FontWeight.w900),
              type: BottomNavigationBarType.shifting,
              items: const [
                BottomNavigationBarItem(
                    backgroundColor: Colors.transparent,
                    activeIcon: Icon(Icons.home_filled),
                    icon: Icon(Icons.home_outlined, color: Colors.black45),
                    label: 'Home'),
                BottomNavigationBarItem(
                    backgroundColor: Colors.transparent,
                    activeIcon: Icon(Icons.location_searching_rounded),
                    icon: Icon(Icons.search_outlined, color: Colors.black45),
                    label: 'Search'),
              ],
              currentIndex: selectedIndex,
              onTap: onTapped,
            ),
          ),
        ),
      ),
    );
  }

  void onTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  void getScreens() {
    screens.add(
        HomeScreen(latitude: widget.latitude, longitude: widget.longitude));
    screens.add(const SearchScreen());
  }
}
