import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/const/gradient_const.dart';
import 'package:weather_app/model/weather_model.dart';
import 'package:weather_app/service/weather_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future weather;
  late WeatherModel weatherData;
  int selectedIndex = 0;

  @override
  void initState() {
    getWeather();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: weather,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              weatherData = snapshot.data!;
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.55,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(20)),
                      child: Stack(
                        children: [
                          Align(
                              alignment: Alignment.topCenter,
                              child: Text(
                                weatherData.name ?? "",
                                style: GoogleFonts.alatsi(
                                    fontSize: 40, fontWeight: FontWeight.w900),
                              )),
                          Positioned(
                              top: 50,
                              right: 10,
                              child: Column(
                                children: [
                                  Text(
                                    (20).toString(),
                                    style: GoogleFonts.concertOne(
                                        fontSize: 100, color: Colors.black45),
                                  ),
                                  const Text("feels like 18")
                                ],
                              ))
                        ],
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      buildCards(
                          icon: Icons.air,
                          name: "Wind",
                          data: '${weatherData.wind?.speed} Km/hr'),
                      buildCards(
                          icon: CupertinoIcons.thermometer,
                          name: "Pressure",
                          data: '${weatherData.main?.pressure} MB'),
                      buildCards(
                          icon: CupertinoIcons.drop,
                          name: "Humidity",
                          data: '${weatherData.main?.humidity} %'),
                    ],
                  ),
                ],
              );
            }
            return const Text("no data found");
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          return const Text("no data found");
        });
  }

  Widget buildCards(
      {required IconData icon, required String name, required String data}) {
    return Expanded(
      child: Card(
          margin: const EdgeInsets.all(10),
          child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: GradientConst.gradientCardBackground.value),
              height: 100,
              width: 80,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(icon),
                  Text(name,
                      style: GoogleFonts.abrilFatface(
                        fontWeight: FontWeight.w500,
                      )),
                  Text(
                    data,
                    style: GoogleFonts.roboto(),
                  )
                ],
              ))),
    );
  }

  void getWeather() {
    weather = WeatherService.getWeather();
  }
}
