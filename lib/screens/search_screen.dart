import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/service/weather_service.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController textEditingController = TextEditingController();
  bool isDataReceived = false;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
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
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(width: 1, color: Colors.black),
                  ),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(
                        width: 10,
                        color: Colors.black,
                        style: BorderStyle.solid),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  hintText: "Location",
                  suffixIcon: IconButton(
                      onPressed: () {
                        getWeatherData(textEditingController.text);
                        setState(() {
                          isDataReceived = true;
                        });
                      },
                      icon: const Icon(Icons.search_outlined))),
            ),
          ),
          isDataReceived
              ? FutureBuilder(
                  future: getWeatherData(textEditingController.text),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (!snapshot.hasData) {
                        return Column(
                          children: [
                            Image.asset(
                              "assets/noData2.png",
                            ),
                            Text("No data found",
                                style: GoogleFonts.alatsi(
                                    fontSize: 18, fontWeight: FontWeight.w800)),
                          ],
                        );
                      }
                      final weather = snapshot.data!;
                      return Column(
                        children: [
                          Center(
                            child: Text(weather.name ?? "Mysore",
                                style: GoogleFonts.alatsi(
                                    fontSize: 40, fontWeight: FontWeight.w900)),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.75,
                            child: const Divider(
                              color: Colors.black45,
                            ),
                          ),
                          Card(
                            margin: const EdgeInsets.only(left: 20),
                            elevation: 0,
                            color: Colors.transparent,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  (weather.main?.temp).toString(),
                                  style: GoogleFonts.concertOne(
                                      fontSize: 80, color: Colors.black45),
                                ),
                                Text("°C",
                                    style: GoogleFonts.concertOne(
                                        fontSize: 30, color: Colors.black45)),
                                const SizedBox(width: 30),
                                Expanded(
                                  child: Text(
                                      weather.weather?[0].description ?? "",
                                      style: GoogleFonts.alatsi(
                                          fontSize: 25,
                                          fontWeight: FontWeight.w800)),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 150,
                            width: 150,
                            child: Image.network(
                                "http://openweathermap.org/img/w/${weather.weather?[0].icon}.png",
                                fit: BoxFit.contain),
                          ),
                          Text("Weather Details",
                              style: GoogleFonts.alatsi(
                                  fontSize: 25, fontWeight: FontWeight.w800)),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.75,
                            child: const Divider(
                              color: Colors.black45,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              detail('${weather.main?.humidity} %', "Humidity"),
                              detail(
                                  '${weather.main?.pressure} MB', "Pressure"),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              detail("${weather.main?.feelsLike} °C",
                                  "Temperature felt"),
                              detail('${weather.wind?.speed} Km/hr', "Wind"),
                            ],
                          ),
                        ],
                      );
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return Column(
                        children: [
                          Image.asset(
                            "assets/noData2.png",
                          ),
                          Text("No data found",
                              style: GoogleFonts.alatsi(
                                  fontSize: 18, fontWeight: FontWeight.w800)),
                        ],
                      );
                    }
                  })
              : Column(
                  children: [
                    Image.asset(
                      "assets/search.png",
                    ),
                    Text("Search By Location Name",
                        style: GoogleFonts.alatsi(
                            fontSize: 18, fontWeight: FontWeight.w800)),
                  ],
                )
        ],
      ),
    );
  }

  Widget detail(String data, String text) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(children: [
        Text(data,
            style:
                GoogleFonts.alatsi(fontSize: 25, fontWeight: FontWeight.w800)),
        Text(text,
            style:
                GoogleFonts.alatsi(fontSize: 15, fontWeight: FontWeight.w800))
      ]),
    );
  }

  Future<dynamic> getWeatherData(String location) {
    return WeatherService.getWeatherBySearch(location);
  }
}
