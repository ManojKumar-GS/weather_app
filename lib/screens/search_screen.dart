import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/model/weather_model.dart';
import 'package:weather_app/service/weather_service.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController textEditingController = TextEditingController();
  late WeatherModel weather;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: TextField(
            controller: textEditingController,
            decoration: InputDecoration(
                counterStyle: GoogleFonts.robotoFlex(
                    fontSize: 30,
                    color: Colors.black,
                    fontWeight: FontWeight.w900),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                hintText: "Location",
                suffixIcon: IconButton(
                    onPressed: () {
                      getWeatherData(textEditingController.text);
                    },
                    icon: const Icon(Icons.search_outlined))),
          ),
        ),
      ],
    );
  }

  getWeatherData(String location) {
    weather = WeatherService.getWeatherBySearch(location);
  }
}
