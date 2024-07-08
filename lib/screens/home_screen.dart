import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/const/gradient_const.dart';
import 'package:weather_app/model/forecast_model.dart';
import 'package:weather_app/model/weather_model.dart';
import 'package:weather_app/screens/weather_forecast_screen.dart';
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
  late Future<dynamic> forecast;
  late Forecast forecastData;
  List todayList = [];

  String currentTime = '';
  String todayDate = "";
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    getWeather();
    getWeatherForecast();
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
    todayDate = DateFormat('EEE d MMM').format(now);

    setState(() {
      currentTime = formattedTime;
    });

    _timer = Timer(
      const Duration(seconds: 1) - Duration(milliseconds: now.millisecond),
      _updateTime,
    );
  }

  getTodayWeatherForecast() {
    forecastData.list?.forEach((element) {
      if (DateFormat('EEE d MMM')
              .format(DateTime.parse(element.dtTxt.substring(0, 10))) ==
          todayDate) {
        todayList.add({
          'icon': element.weather[0].icon,
          'desc': element.weather[0].description,
          'temp': element.main.temp,
          'time': DateFormat('hh:mm').format(DateTime.parse(element.dtTxt))
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FutureBuilder(
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
                                            fontSize: 30,
                                            color: Colors.black45))
                                  ],
                                ),
                                Text(
                                    "feels like ${weatherData.main?.feelsLike} °C")
                              ],
                            )
                          ],
                        ),
                        Text(
                          (weatherData.weather?[0].description).toString(),
                          style: GoogleFonts.concertOne(
                              fontSize: 80, color: Colors.black),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Text("Weather Details",
                              style: GoogleFonts.alatsi(
                                  fontSize: 25, fontWeight: FontWeight.w800)),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.75,
                          child: const Divider(
                            color: Colors.black45,
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
                  return Column(
                    children: [
                      Image.asset(
                        "assets/noData1.png",
                      ),
                      Text("Weather Data Not Found",
                          style: GoogleFonts.alatsi(
                              fontSize: 18, fontWeight: FontWeight.w800)),
                    ],
                  );
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Align(
                      alignment: Alignment.center,
                      child: CircularProgressIndicator());
                }
                return Column(
                  children: [
                    Image.asset(
                      "assets/noData1.png",
                    ),
                    Text("Weather Data Not Found",
                        style: GoogleFonts.alatsi(
                            fontSize: 18, fontWeight: FontWeight.w800)),
                  ],
                );
              }),
          weatherForecast()
        ],
      ),
    );
  }

  Widget weatherForecast() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Weather Forecast",
                style: GoogleFonts.concertOne(
                    fontSize: 30, color: Colors.black45)),
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ForecastUi(forecastData: forecastData)));
                  },
                  icon: const Icon(
                    CupertinoIcons.right_chevron,
                    color: Colors.black,
                  )),
            )
          ],
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.75,
          child: const Divider(
            color: Colors.black45,
          ),
        ),
        FutureBuilder(
          future: forecast,
          initialData: Forecast(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                forecastData = snapshot.data!;
                if (todayList.isEmpty) {
                  getTodayWeatherForecast();
                }
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text("Today's weather forecast",
                          style: GoogleFonts.concertOne(
                              fontSize: 20, color: Colors.black)),
                    ),
                    ListView.builder(
                      physics: const ScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: todayList.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: 0.2,
                          color: Colors.transparent,
                          child: ListTile(
                            trailing: Text('${todayList[index]['temp']}°C',
                                style: GoogleFonts.concertOne(
                                    fontSize: 30, color: Colors.black)),
                            title: Text(todayList[index]['desc'],
                                style: GoogleFonts.actor(
                                    fontSize: 30, color: Colors.black)),
                            subtitle: Text(todayList[index]['time'].toString(),
                                style: GoogleFonts.aBeeZee(
                                    fontSize: 20, color: Colors.black)),
                            leading: Image.network(
                              "http://openweathermap.org/img/w/${todayList[index]['icon']}.png",
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                );
              }
              return Column(
                children: [
                  Image.asset(
                    "assets/noData2.png",
                  ),
                  Text("Forecast not found",
                      style: GoogleFonts.alatsi(
                          fontSize: 18, fontWeight: FontWeight.w800)),
                ],
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            return Column(
              children: [
                Image.asset(
                  "assets/noData2.png",
                ),
                Text("Forecast not found",
                    style: GoogleFonts.alatsi(
                        fontSize: 18, fontWeight: FontWeight.w800)),
              ],
            );
          },
        ),
      ],
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
                  gradient: GradientConst.gradientCardBackground),
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

  void getWeatherForecast() {
    forecast = WeatherService.getWeatherForecast(
        latitude: widget.latitude, longitude: widget.longitude);
  }
}
