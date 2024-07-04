import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/const/gradient_const.dart';
import 'package:weather_app/model/forecast_model.dart';
import 'package:weather_app/model/weather_model.dart';
import 'package:weather_app/service/weather_service.dart';

class HomeScreen extends StatefulWidget {
  final double latitude;
  final double longitude;
  const HomeScreen(
      {super.key, required this.latitude, required this.longitude});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<dynamic> weather;
  late WeatherModel weatherData;
  int selectedIndex = 0;
  Forecast forecast = Forecast();

  String currentTime = '';
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    getWeather();
    _updateTime();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _updateTime() {
    final DateTime now = DateTime.now();
    final String formattedTime = DateFormat('hh:mm a EEE d MMM').format(now);

    setState(() {
      currentTime = formattedTime;
    });

    _timer = Timer(
      const Duration(seconds: 1) - Duration(milliseconds: now.millisecond),
      _updateTime,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: FutureBuilder(
          future: weather,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                weatherData = snapshot.data!;
                return Column(
                  children: [
                    Text(
                      weatherData.name ?? "",
                      style: GoogleFonts.alatsi(
                          fontSize: 40, fontWeight: FontWeight.w900),
                    ),
                    Text(currentTime.toString(),
                        style: GoogleFonts.saira(
                            fontSize: 20, color: Colors.black)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 150,
                          width: 150,
                          child: Image.network(
                              "http://openweathermap.org/img/w/${weatherData.weather?[0].icon}.png",
                              fit: BoxFit.contain),
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  (weatherData.main?.temp).toString(),
                                  style: GoogleFonts.concertOne(
                                      fontSize: 80, color: Colors.black45),
                                ),
                                Text("°C",
                                    style: GoogleFonts.concertOne(
                                        fontSize: 30, color: Colors.black45))
                              ],
                            ),
                            Text("feels like ${weatherData.main?.feelsLike} °C")
                          ],
                        )
                      ],
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
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.75,
                      child: const Divider(
                        color: Colors.black45,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text("Next 3hr Forecast",
                          style: GoogleFonts.concertOne(
                              fontSize: 20, color: Colors.black)),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: 3,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: 0.2,
                          color: Colors.transparent,
                          child: ListTile(
                            trailing: Text("25°C",
                                style: GoogleFonts.concertOne(
                                    fontSize: 30, color: Colors.black)),
                            title: Text("Rainy",
                                style: GoogleFonts.actor(
                                    fontSize: 30, color: Colors.black)),
                            subtitle: Text("21:30",
                                style: GoogleFonts.aBeeZee(
                                    fontSize: 20, color: Colors.black)),
                            leading: const Icon(Icons.sunny, size: 40),
                          ),
                        );
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text("Next 5 days Forecast",
                          style: GoogleFonts.concertOne(
                              fontSize: 20, color: Colors.black)),
                    ),
                    SizedBox(
                      height: 220,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: 8,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Card(
                            margin: const EdgeInsets.all(10),
                            elevation: 0.2,
                            color: Colors.transparent,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.network(
                                    "http://openweathermap.org/img/w/10d.png"),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      right: 10.0, left: 10),
                                  child: Text(
                                      forecast.list?[index].main.temp
                                              .toString() ??
                                          "",
                                      style: GoogleFonts.concertOne(
                                          fontSize: 25, color: Colors.black45)),
                                ),
                                SizedBox(
                                  width: 50,
                                  child: Text(
                                    forecast.list?[index].weather[index]
                                            .description ??
                                        "",
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.justify,
                                    style: GoogleFonts.alef(
                                      fontSize: 20,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                ),
                                Text(forecast.list?[index].dtTxt ?? "",
                                    style: GoogleFonts.aBeeZee(
                                        fontSize: 15,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w900)),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              }
              return const Center(child: Text("no data found"));
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            return const Center(child: Text("no data found"));
          }),
    );
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
    weather = WeatherService.getCurrentWeather(
        latitude: widget.latitude, longitude: widget.longitude);
  }
}
