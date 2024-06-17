import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
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
  late Future<WeatherModel> weather;
  late WeatherModel weatherData;
  int selectedIndex = 0;

  late Position currentPosition;
  final currentTime = DateTime.now();

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
                                  Row(
                                    children: [
                                      Text(
                                        (weatherData.main?.temp).toString(),
                                        style: GoogleFonts.concertOne(
                                            fontSize: 80,
                                            color: Colors.black45),
                                      ),
                                      Text("°C",
                                          style: GoogleFonts.concertOne(
                                              fontSize: 30,
                                              color: Colors.black45))
                                    ],
                                  ),
                                  Text(
                                      "feels like ${weatherData.main?.feelsLike}")
                                ],
                              )),
                          Positioned(
                              bottom: 10,
                              right: 20,
                              child: Text(currentTime.toString(),
                                  style: GoogleFonts.saira(
                                      fontSize: 20, color: Colors.black45)))
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
                  Text("Weather Forecast",
                      style: GoogleFonts.concertOne(
                          fontSize: 30, color: Colors.black45)),
                  Container()
                ],
              );
            }
            return const Text("no data found");
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
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

  Future<void> getWeather() async {
    currentPosition = await _determinePosition();
    weather = await WeatherService.getCurrentWeather(currentPosition);
  }
}
