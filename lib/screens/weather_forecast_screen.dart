import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/const/gradient_const.dart';
import 'package:weather_app/model/forecast_model.dart';

class ForecastUi extends StatefulWidget {
  final Forecast forecastData;
  const ForecastUi({super.key, required this.forecastData});

  @override
  State<ForecastUi> createState() => _ForecastUiState();
}

class _ForecastUiState extends State<ForecastUi> {
  late Forecast forecastData;
  List<String> dateList = [];
  List dailyForecast = [];

  @override
  initState() {
    forecastData = widget.forecastData;
    if (dateList.isEmpty) {
      getDataList();
    }
    super.initState();
  }

  getDataList() {
    String value = "";
    String value1 = "";
    (forecastData.list ?? []).forEach((element) {
      value = element.dtTxt.substring(0, 10);

      if (value != value1) {
        value1 = value;
        dateList.add(DateFormat('EEE d MMM').format(DateTime.parse(value1)));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(gradient: GradientConst.gradientBackground),
        child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              title: Column(
                children: [
                  Text(
                    "Weather Forecast",
                    style: GoogleFonts.concertOne(
                        fontSize: 25, color: Colors.black45),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.75,
                    child: const Divider(
                      color: Colors.black45,
                    ),
                  ),
                ],
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  IconButton(
                      onPressed: () {
                        getTodayWeatherForecast();
                      },
                      icon: Icon(Icons.access_alarm)),
                  ListView.builder(
                      physics: const ScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: 5,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: [
                            Text(dateList[index],
                                style: GoogleFonts.concertOne(
                                    fontSize: 30, color: Colors.black45)),
                            forecastWidget(),
                          ],
                        );
                      }),
                ],
              ),
            )),
      ),
    );
  }

  Widget forecastWidget() {
    return SizedBox(
      height: 220,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: 40,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.all(10),
            elevation: 0.2,
            color: Colors.transparent,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.network(
                    "http://openweathermap.org/img/w/${forecastData.list?[index].weather[0].icon}.png"),
                Padding(
                  padding: const EdgeInsets.only(right: 10.0, left: 10),
                  child: Text(
                      (forecastData.list?[index].main.temp ?? 0).toString(),
                      style: GoogleFonts.concertOne(
                          fontSize: 25, color: Colors.black45)),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10.0, left: 10),
                  child: SizedBox(
                    width: 60,
                    child: Text(
                      forecastData.list?[index].weather[0].description ?? "",
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.justify,
                      style: GoogleFonts.alef(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ),
                Text(
                    DateFormat('hh:mm').format(
                        DateTime.parse(forecastData.list?[index].dtTxt ?? "")),
                    style: GoogleFonts.aBeeZee(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.w900)),
              ],
            ),
          );
        },
      ),
    );
  }
}
