import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/model/forecast_model.dart';

class ForecastUi extends StatefulWidget {
  const ForecastUi({super.key});

  @override
  State<ForecastUi> createState() => _ForecastUiState();
}

class _ForecastUiState extends State<ForecastUi> {
  List<String> dateList = [];

  @override
  initState() {
    getDataList();
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
      child: Scaffold(
          body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Text("Weather Forecast",
                  style: GoogleFonts.concertOne(
                      fontSize: 30, color: Colors.black45)),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.75,
              child: const Divider(
                color: Colors.black45,
              ),
            ),
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
    );
  }

  Widget forecastWidget() {
    print(dateList);
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

  Forecast forecastData = Forecast.fromJson({
    "cod": "200",
    "message": 0,
    "cnt": 40,
    "list": [
      {
        "dt": 1720245600,
        "main": {
          "temp": 15.99,
          "feels_like": 15.66,
          "temp_min": 15.99,
          "temp_max": 18.11,
          "pressure": 1013,
          "sea_level": 1013,
          "grnd_level": 930,
          "humidity": 77,
          "temp_kf": -2.12
        },
        "weather": [
          {
            "id": 802,
            "main": "Clouds",
            "description": "scattered clouds",
            "icon": "03d"
          }
        ],
        "clouds": {"all": 29},
        "wind": {"speed": 1.83, "deg": 191, "gust": 3.16},
        "visibility": 10000,
        "pop": 0,
        "sys": {"pod": "d"},
        "dt_txt": "2024-07-06 06:00:00"
      },
      {
        "dt": 1720256400,
        "main": {
          "temp": 18.49,
          "feels_like": 18.12,
          "temp_min": 18.49,
          "temp_max": 23.49,
          "pressure": 1013,
          "sea_level": 1013,
          "grnd_level": 931,
          "humidity": 66,
          "temp_kf": -5
        },
        "weather": [
          {
            "id": 801,
            "main": "Clouds",
            "description": "few clouds",
            "icon": "02d"
          }
        ],
        "clouds": {"all": 19},
        "wind": {"speed": 0.5, "deg": 195, "gust": 2.64},
        "visibility": 10000,
        "pop": 0,
        "sys": {"pod": "d"},
        "dt_txt": "2024-07-06 09:00:00"
      },
      {
        "dt": 1720267200,
        "main": {
          "temp": 22.77,
          "feels_like": 22.43,
          "temp_min": 22.77,
          "temp_max": 26.16,
          "pressure": 1012,
          "sea_level": 1012,
          "grnd_level": 930,
          "humidity": 51,
          "temp_kf": -3.39
        },
        "weather": [
          {
            "id": 801,
            "main": "Clouds",
            "description": "few clouds",
            "icon": "02d"
          }
        ],
        "clouds": {"all": 11},
        "wind": {"speed": 1, "deg": 162, "gust": 3.99},
        "visibility": 10000,
        "pop": 0,
        "sys": {"pod": "d"},
        "dt_txt": "2024-07-06 12:00:00"
      },
      {
        "dt": 1720278000,
        "main": {
          "temp": 26.47,
          "feels_like": 26.47,
          "temp_min": 26.47,
          "temp_max": 26.47,
          "pressure": 1010,
          "sea_level": 1010,
          "grnd_level": 929,
          "humidity": 40,
          "temp_kf": 0
        },
        "weather": [
          {
            "id": 800,
            "main": "Clear",
            "description": "clear sky",
            "icon": "01d"
          }
        ],
        "clouds": {"all": 10},
        "wind": {"speed": 1.41, "deg": 201, "gust": 4.07},
        "visibility": 10000,
        "pop": 0,
        "sys": {"pod": "d"},
        "dt_txt": "2024-07-06 15:00:00"
      },
      {
        "dt": 1720288800,
        "main": {
          "temp": 21.36,
          "feels_like": 21.22,
          "temp_min": 21.36,
          "temp_max": 21.36,
          "pressure": 1011,
          "sea_level": 1011,
          "grnd_level": 928,
          "humidity": 64,
          "temp_kf": 0
        },
        "weather": [
          {
            "id": 801,
            "main": "Clouds",
            "description": "few clouds",
            "icon": "02d"
          }
        ],
        "clouds": {"all": 18},
        "wind": {"speed": 0.84, "deg": 225, "gust": 4.08},
        "visibility": 10000,
        "pop": 0,
        "sys": {"pod": "d"},
        "dt_txt": "2024-07-06 18:00:00"
      },
      {
        "dt": 1720299600,
        "main": {
          "temp": 16.36,
          "feels_like": 15.93,
          "temp_min": 16.36,
          "temp_max": 16.36,
          "pressure": 1012,
          "sea_level": 1012,
          "grnd_level": 928,
          "humidity": 72,
          "temp_kf": 0
        },
        "weather": [
          {
            "id": 801,
            "main": "Clouds",
            "description": "few clouds",
            "icon": "02n"
          }
        ],
        "clouds": {"all": 18},
        "wind": {"speed": 3.15, "deg": 212, "gust": 5.53},
        "visibility": 10000,
        "pop": 0,
        "sys": {"pod": "n"},
        "dt_txt": "2024-07-06 21:00:00"
      },
      {
        "dt": 1720310400,
        "main": {
          "temp": 14.78,
          "feels_like": 14.22,
          "temp_min": 14.78,
          "temp_max": 14.78,
          "pressure": 1012,
          "sea_level": 1012,
          "grnd_level": 928,
          "humidity": 73,
          "temp_kf": 0
        },
        "weather": [
          {
            "id": 801,
            "main": "Clouds",
            "description": "few clouds",
            "icon": "02n"
          }
        ],
        "clouds": {"all": 17},
        "wind": {"speed": 2.87, "deg": 205, "gust": 3.96},
        "visibility": 10000,
        "pop": 0,
        "sys": {"pod": "n"},
        "dt_txt": "2024-07-07 00:00:00"
      },
      {
        "dt": 1720321200,
        "main": {
          "temp": 14.38,
          "feels_like": 13.78,
          "temp_min": 14.38,
          "temp_max": 14.38,
          "pressure": 1012,
          "sea_level": 1012,
          "grnd_level": 928,
          "humidity": 73,
          "temp_kf": 0
        },
        "weather": [
          {
            "id": 800,
            "main": "Clear",
            "description": "clear sky",
            "icon": "01n"
          }
        ],
        "clouds": {"all": 2},
        "wind": {"speed": 2.67, "deg": 203, "gust": 3.83},
        "visibility": 10000,
        "pop": 0,
        "sys": {"pod": "n"},
        "dt_txt": "2024-07-07 03:00:00"
      },
      {
        "dt": 1720332000,
        "main": {
          "temp": 18.42,
          "feels_like": 17.96,
          "temp_min": 18.42,
          "temp_max": 18.42,
          "pressure": 1013,
          "sea_level": 1013,
          "grnd_level": 929,
          "humidity": 63,
          "temp_kf": 0
        },
        "weather": [
          {
            "id": 801,
            "main": "Clouds",
            "description": "few clouds",
            "icon": "02d"
          }
        ],
        "clouds": {"all": 17},
        "wind": {"speed": 1.67, "deg": 193, "gust": 3.11},
        "visibility": 10000,
        "pop": 0,
        "sys": {"pod": "d"},
        "dt_txt": "2024-07-07 06:00:00"
      },
      {
        "dt": 1720342800,
        "main": {
          "temp": 22.95,
          "feels_like": 22.68,
          "temp_min": 22.95,
          "temp_max": 22.95,
          "pressure": 1012,
          "sea_level": 1012,
          "grnd_level": 930,
          "humidity": 53,
          "temp_kf": 0
        },
        "weather": [
          {
            "id": 803,
            "main": "Clouds",
            "description": "broken clouds",
            "icon": "04d"
          }
        ],
        "clouds": {"all": 84},
        "wind": {"speed": 0.7, "deg": 86, "gust": 2.35},
        "visibility": 10000,
        "pop": 0.05,
        "sys": {"pod": "d"},
        "dt_txt": "2024-07-07 09:00:00"
      },
      {
        "dt": 1720353600,
        "main": {
          "temp": 24.89,
          "feels_like": 24.79,
          "temp_min": 24.89,
          "temp_max": 24.89,
          "pressure": 1012,
          "sea_level": 1012,
          "grnd_level": 930,
          "humidity": 52,
          "temp_kf": 0
        },
        "weather": [
          {
            "id": 500,
            "main": "Rain",
            "description": "light rain",
            "icon": "10d"
          }
        ],
        "clouds": {"all": 68},
        "wind": {"speed": 0.57, "deg": 183, "gust": 3.38},
        "visibility": 10000,
        "pop": 0.39,
        "rain": {"3h": 0.44},
        "sys": {"pod": "d"},
        "dt_txt": "2024-07-07 12:00:00"
      },
      {
        "dt": 1720364400,
        "main": {
          "temp": 25.89,
          "feels_like": 25.81,
          "temp_min": 25.89,
          "temp_max": 25.89,
          "pressure": 1011,
          "sea_level": 1011,
          "grnd_level": 930,
          "humidity": 49,
          "temp_kf": 0
        },
        "weather": [
          {
            "id": 500,
            "main": "Rain",
            "description": "light rain",
            "icon": "10d"
          }
        ],
        "clouds": {"all": 53},
        "wind": {"speed": 0.57, "deg": 239, "gust": 3.63},
        "visibility": 10000,
        "pop": 0.25,
        "rain": {"3h": 0.11},
        "sys": {"pod": "d"},
        "dt_txt": "2024-07-07 15:00:00"
      },
      {
        "dt": 1720375200,
        "main": {
          "temp": 20.17,
          "feels_like": 20.36,
          "temp_min": 20.17,
          "temp_max": 20.17,
          "pressure": 1013,
          "sea_level": 1013,
          "grnd_level": 929,
          "humidity": 81,
          "temp_kf": 0
        },
        "weather": [
          {
            "id": 500,
            "main": "Rain",
            "description": "light rain",
            "icon": "10d"
          }
        ],
        "clouds": {"all": 51},
        "wind": {"speed": 0.44, "deg": 11, "gust": 1.64},
        "visibility": 10000,
        "pop": 0.45,
        "rain": {"3h": 0.69},
        "sys": {"pod": "d"},
        "dt_txt": "2024-07-07 18:00:00"
      },
      {
        "dt": 1720386000,
        "main": {
          "temp": 16.77,
          "feels_like": 16.83,
          "temp_min": 16.77,
          "temp_max": 16.77,
          "pressure": 1014,
          "sea_level": 1014,
          "grnd_level": 930,
          "humidity": 89,
          "temp_kf": 0
        },
        "weather": [
          {
            "id": 800,
            "main": "Clear",
            "description": "clear sky",
            "icon": "01n"
          }
        ],
        "clouds": {"all": 0},
        "wind": {"speed": 1.44, "deg": 228, "gust": 1.34},
        "visibility": 10000,
        "pop": 0.47,
        "sys": {"pod": "n"},
        "dt_txt": "2024-07-07 21:00:00"
      },
      {
        "dt": 1720396800,
        "main": {
          "temp": 15.91,
          "feels_like": 15.98,
          "temp_min": 15.91,
          "temp_max": 15.91,
          "pressure": 1015,
          "sea_level": 1015,
          "grnd_level": 930,
          "humidity": 93,
          "temp_kf": 0
        },
        "weather": [
          {
            "id": 800,
            "main": "Clear",
            "description": "clear sky",
            "icon": "01n"
          }
        ],
        "clouds": {"all": 0},
        "wind": {"speed": 1.74, "deg": 238, "gust": 1.71},
        "visibility": 10000,
        "pop": 0.31,
        "sys": {"pod": "n"},
        "dt_txt": "2024-07-08 00:00:00"
      },
      {
        "dt": 1720407600,
        "main": {
          "temp": 15.16,
          "feels_like": 15.21,
          "temp_min": 15.16,
          "temp_max": 15.16,
          "pressure": 1015,
          "sea_level": 1015,
          "grnd_level": 930,
          "humidity": 95,
          "temp_kf": 0
        },
        "weather": [
          {
            "id": 801,
            "main": "Clouds",
            "description": "few clouds",
            "icon": "02n"
          }
        ],
        "clouds": {"all": 14},
        "wind": {"speed": 1.32, "deg": 247, "gust": 1.35},
        "visibility": 10000,
        "pop": 0,
        "sys": {"pod": "n"},
        "dt_txt": "2024-07-08 03:00:00"
      },
      {
        "dt": 1720418400,
        "main": {
          "temp": 18.33,
          "feels_like": 18.41,
          "temp_min": 18.33,
          "temp_max": 18.33,
          "pressure": 1016,
          "sea_level": 1016,
          "grnd_level": 932,
          "humidity": 84,
          "temp_kf": 0
        },
        "weather": [
          {
            "id": 802,
            "main": "Clouds",
            "description": "scattered clouds",
            "icon": "03d"
          }
        ],
        "clouds": {"all": 25},
        "wind": {"speed": 0.6, "deg": 282, "gust": 0.82},
        "visibility": 10000,
        "pop": 0,
        "sys": {"pod": "d"},
        "dt_txt": "2024-07-08 06:00:00"
      },
      {
        "dt": 1720429200,
        "main": {
          "temp": 22.07,
          "feels_like": 22.11,
          "temp_min": 22.07,
          "temp_max": 22.07,
          "pressure": 1016,
          "sea_level": 1016,
          "grnd_level": 933,
          "humidity": 68,
          "temp_kf": 0
        },
        "weather": [
          {
            "id": 803,
            "main": "Clouds",
            "description": "broken clouds",
            "icon": "04d"
          }
        ],
        "clouds": {"all": 59},
        "wind": {"speed": 0.76, "deg": 3, "gust": 1.04},
        "visibility": 10000,
        "pop": 0,
        "sys": {"pod": "d"},
        "dt_txt": "2024-07-08 09:00:00"
      },
      {
        "dt": 1720440000,
        "main": {
          "temp": 25.76,
          "feels_like": 25.72,
          "temp_min": 25.76,
          "temp_max": 25.76,
          "pressure": 1016,
          "sea_level": 1016,
          "grnd_level": 934,
          "humidity": 51,
          "temp_kf": 0
        },
        "weather": [
          {
            "id": 500,
            "main": "Rain",
            "description": "light rain",
            "icon": "10d"
          }
        ],
        "clouds": {"all": 68},
        "wind": {"speed": 2.03, "deg": 21, "gust": 2.82},
        "visibility": 10000,
        "pop": 0.24,
        "rain": {"3h": 0.19},
        "sys": {"pod": "d"},
        "dt_txt": "2024-07-08 12:00:00"
      },
      {
        "dt": 1720450800,
        "main": {
          "temp": 26.77,
          "feels_like": 27.1,
          "temp_min": 26.77,
          "temp_max": 26.77,
          "pressure": 1015,
          "sea_level": 1015,
          "grnd_level": 933,
          "humidity": 48,
          "temp_kf": 0
        },
        "weather": [
          {
            "id": 802,
            "main": "Clouds",
            "description": "scattered clouds",
            "icon": "03d"
          }
        ],
        "clouds": {"all": 28},
        "wind": {"speed": 2.3, "deg": 20, "gust": 2.28},
        "visibility": 10000,
        "pop": 0,
        "sys": {"pod": "d"},
        "dt_txt": "2024-07-08 15:00:00"
      },
      {
        "dt": 1720461600,
        "main": {
          "temp": 22.53,
          "feels_like": 22.74,
          "temp_min": 22.53,
          "temp_max": 22.53,
          "pressure": 1015,
          "sea_level": 1015,
          "grnd_level": 933,
          "humidity": 73,
          "temp_kf": 0
        },
        "weather": [
          {
            "id": 801,
            "main": "Clouds",
            "description": "few clouds",
            "icon": "02d"
          }
        ],
        "clouds": {"all": 17},
        "wind": {"speed": 1.99, "deg": 22, "gust": 2.77},
        "visibility": 10000,
        "pop": 0,
        "sys": {"pod": "d"},
        "dt_txt": "2024-07-08 18:00:00"
      },
      {
        "dt": 1720472400,
        "main": {
          "temp": 18.44,
          "feels_like": 18.61,
          "temp_min": 18.44,
          "temp_max": 18.44,
          "pressure": 1017,
          "sea_level": 1017,
          "grnd_level": 933,
          "humidity": 87,
          "temp_kf": 0
        },
        "weather": [
          {
            "id": 802,
            "main": "Clouds",
            "description": "scattered clouds",
            "icon": "03n"
          }
        ],
        "clouds": {"all": 27},
        "wind": {"speed": 0.77, "deg": 279, "gust": 0.87},
        "visibility": 10000,
        "pop": 0,
        "sys": {"pod": "n"},
        "dt_txt": "2024-07-08 21:00:00"
      },
      {
        "dt": 1720483200,
        "main": {
          "temp": 17.31,
          "feels_like": 17.5,
          "temp_min": 17.31,
          "temp_max": 17.31,
          "pressure": 1017,
          "sea_level": 1017,
          "grnd_level": 933,
          "humidity": 92,
          "temp_kf": 0
        },
        "weather": [
          {
            "id": 801,
            "main": "Clouds",
            "description": "few clouds",
            "icon": "02n"
          }
        ],
        "clouds": {"all": 14},
        "wind": {"speed": 1.35, "deg": 242, "gust": 1.3},
        "visibility": 10000,
        "pop": 0,
        "sys": {"pod": "n"},
        "dt_txt": "2024-07-09 00:00:00"
      },
      {
        "dt": 1720494000,
        "main": {
          "temp": 16.7,
          "feels_like": 16.85,
          "temp_min": 16.7,
          "temp_max": 16.7,
          "pressure": 1017,
          "sea_level": 1017,
          "grnd_level": 933,
          "humidity": 93,
          "temp_kf": 0
        },
        "weather": [
          {
            "id": 800,
            "main": "Clear",
            "description": "clear sky",
            "icon": "01n"
          }
        ],
        "clouds": {"all": 0},
        "wind": {"speed": 1.2, "deg": 252, "gust": 1.19},
        "visibility": 10000,
        "pop": 0.01,
        "sys": {"pod": "n"},
        "dt_txt": "2024-07-09 03:00:00"
      },
      {
        "dt": 1720504800,
        "main": {
          "temp": 20.09,
          "feels_like": 20.32,
          "temp_min": 20.09,
          "temp_max": 20.09,
          "pressure": 1017,
          "sea_level": 1017,
          "grnd_level": 934,
          "humidity": 83,
          "temp_kf": 0
        },
        "weather": [
          {
            "id": 800,
            "main": "Clear",
            "description": "clear sky",
            "icon": "01d"
          }
        ],
        "clouds": {"all": 0},
        "wind": {"speed": 0.76, "deg": 332, "gust": 1.27},
        "visibility": 10000,
        "pop": 0.01,
        "sys": {"pod": "d"},
        "dt_txt": "2024-07-09 06:00:00"
      },
      {
        "dt": 1720515600,
        "main": {
          "temp": 24.72,
          "feels_like": 24.84,
          "temp_min": 24.72,
          "temp_max": 24.72,
          "pressure": 1017,
          "sea_level": 1017,
          "grnd_level": 935,
          "humidity": 61,
          "temp_kf": 0
        },
        "weather": [
          {
            "id": 800,
            "main": "Clear",
            "description": "clear sky",
            "icon": "01d"
          }
        ],
        "clouds": {"all": 3},
        "wind": {"speed": 2.25, "deg": 19, "gust": 1.6},
        "visibility": 10000,
        "pop": 0,
        "sys": {"pod": "d"},
        "dt_txt": "2024-07-09 09:00:00"
      },
      {
        "dt": 1720526400,
        "main": {
          "temp": 28.04,
          "feels_like": 28.07,
          "temp_min": 28.04,
          "temp_max": 28.04,
          "pressure": 1016,
          "sea_level": 1016,
          "grnd_level": 935,
          "humidity": 45,
          "temp_kf": 0
        },
        "weather": [
          {
            "id": 801,
            "main": "Clouds",
            "description": "few clouds",
            "icon": "02d"
          }
        ],
        "clouds": {"all": 13},
        "wind": {"speed": 2.57, "deg": 24, "gust": 2.26},
        "visibility": 10000,
        "pop": 0,
        "sys": {"pod": "d"},
        "dt_txt": "2024-07-09 12:00:00"
      },
      {
        "dt": 1720537200,
        "main": {
          "temp": 27.85,
          "feels_like": 28.12,
          "temp_min": 27.85,
          "temp_max": 27.85,
          "pressure": 1016,
          "sea_level": 1016,
          "grnd_level": 934,
          "humidity": 48,
          "temp_kf": 0
        },
        "weather": [
          {
            "id": 500,
            "main": "Rain",
            "description": "light rain",
            "icon": "10d"
          }
        ],
        "clouds": {"all": 39},
        "wind": {"speed": 2.34, "deg": 5, "gust": 2.21},
        "visibility": 10000,
        "pop": 0.28,
        "rain": {"3h": 0.16},
        "sys": {"pod": "d"},
        "dt_txt": "2024-07-09 15:00:00"
      },
      {
        "dt": 1720548000,
        "main": {
          "temp": 24.09,
          "feels_like": 24.3,
          "temp_min": 24.09,
          "temp_max": 24.09,
          "pressure": 1016,
          "sea_level": 1016,
          "grnd_level": 933,
          "humidity": 67,
          "temp_kf": 0
        },
        "weather": [
          {
            "id": 802,
            "main": "Clouds",
            "description": "scattered clouds",
            "icon": "03d"
          }
        ],
        "clouds": {"all": 30},
        "wind": {"speed": 1.87, "deg": 14, "gust": 2.02},
        "visibility": 10000,
        "pop": 0.08,
        "sys": {"pod": "d"},
        "dt_txt": "2024-07-09 18:00:00"
      },
      {
        "dt": 1720558800,
        "main": {
          "temp": 19.65,
          "feels_like": 19.76,
          "temp_min": 19.65,
          "temp_max": 19.65,
          "pressure": 1018,
          "sea_level": 1018,
          "grnd_level": 934,
          "humidity": 80,
          "temp_kf": 0
        },
        "weather": [
          {
            "id": 800,
            "main": "Clear",
            "description": "clear sky",
            "icon": "01n"
          }
        ],
        "clouds": {"all": 0},
        "wind": {"speed": 1, "deg": 258, "gust": 1.05},
        "visibility": 10000,
        "pop": 0,
        "sys": {"pod": "n"},
        "dt_txt": "2024-07-09 21:00:00"
      },
      {
        "dt": 1720569600,
        "main": {
          "temp": 18.82,
          "feels_like": 18.92,
          "temp_min": 18.82,
          "temp_max": 18.82,
          "pressure": 1017,
          "sea_level": 1017,
          "grnd_level": 933,
          "humidity": 83,
          "temp_kf": 0
        },
        "weather": [
          {
            "id": 800,
            "main": "Clear",
            "description": "clear sky",
            "icon": "01n"
          }
        ],
        "clouds": {"all": 0},
        "wind": {"speed": 1.63, "deg": 241, "gust": 1.51},
        "visibility": 10000,
        "pop": 0,
        "sys": {"pod": "n"},
        "dt_txt": "2024-07-10 00:00:00"
      },
      {
        "dt": 1720580400,
        "main": {
          "temp": 18,
          "feels_like": 18.1,
          "temp_min": 18,
          "temp_max": 18,
          "pressure": 1016,
          "sea_level": 1016,
          "grnd_level": 932,
          "humidity": 86,
          "temp_kf": 0
        },
        "weather": [
          {
            "id": 800,
            "main": "Clear",
            "description": "clear sky",
            "icon": "01n"
          }
        ],
        "clouds": {"all": 5},
        "wind": {"speed": 1.2, "deg": 230, "gust": 1.13},
        "visibility": 10000,
        "pop": 0,
        "sys": {"pod": "n"},
        "dt_txt": "2024-07-10 03:00:00"
      },
      {
        "dt": 1720591200,
        "main": {
          "temp": 21.84,
          "feels_like": 22.01,
          "temp_min": 21.84,
          "temp_max": 21.84,
          "pressure": 1017,
          "sea_level": 1017,
          "grnd_level": 934,
          "humidity": 74,
          "temp_kf": 0
        },
        "weather": [
          {
            "id": 800,
            "main": "Clear",
            "description": "clear sky",
            "icon": "01d"
          }
        ],
        "clouds": {"all": 5},
        "wind": {"speed": 0.93, "deg": 305, "gust": 1.31},
        "visibility": 10000,
        "pop": 0,
        "sys": {"pod": "d"},
        "dt_txt": "2024-07-10 06:00:00"
      },
      {
        "dt": 1720602000,
        "main": {
          "temp": 26.39,
          "feels_like": 26.39,
          "temp_min": 26.39,
          "temp_max": 26.39,
          "pressure": 1016,
          "sea_level": 1016,
          "grnd_level": 934,
          "humidity": 55,
          "temp_kf": 0
        },
        "weather": [
          {
            "id": 800,
            "main": "Clear",
            "description": "clear sky",
            "icon": "01d"
          }
        ],
        "clouds": {"all": 1},
        "wind": {"speed": 1.94, "deg": 11, "gust": 1.52},
        "visibility": 10000,
        "pop": 0,
        "sys": {"pod": "d"},
        "dt_txt": "2024-07-10 09:00:00"
      },
      {
        "dt": 1720612800,
        "main": {
          "temp": 29.8,
          "feels_like": 29.57,
          "temp_min": 29.8,
          "temp_max": 29.8,
          "pressure": 1015,
          "sea_level": 1015,
          "grnd_level": 934,
          "humidity": 41,
          "temp_kf": 0
        },
        "weather": [
          {
            "id": 800,
            "main": "Clear",
            "description": "clear sky",
            "icon": "01d"
          }
        ],
        "clouds": {"all": 3},
        "wind": {"speed": 2.21, "deg": 18, "gust": 2.32},
        "visibility": 10000,
        "pop": 0,
        "sys": {"pod": "d"},
        "dt_txt": "2024-07-10 12:00:00"
      },
      {
        "dt": 1720623600,
        "main": {
          "temp": 29.94,
          "feels_like": 29.62,
          "temp_min": 29.94,
          "temp_max": 29.94,
          "pressure": 1014,
          "sea_level": 1014,
          "grnd_level": 934,
          "humidity": 40,
          "temp_kf": 0
        },
        "weather": [
          {
            "id": 800,
            "main": "Clear",
            "description": "clear sky",
            "icon": "01d"
          }
        ],
        "clouds": {"all": 5},
        "wind": {"speed": 2.83, "deg": 18, "gust": 2.29},
        "visibility": 10000,
        "pop": 0.04,
        "sys": {"pod": "d"},
        "dt_txt": "2024-07-10 15:00:00"
      },
      {
        "dt": 1720634400,
        "main": {
          "temp": 25.51,
          "feels_like": 25.68,
          "temp_min": 25.51,
          "temp_max": 25.51,
          "pressure": 1014,
          "sea_level": 1014,
          "grnd_level": 932,
          "humidity": 60,
          "temp_kf": 0
        },
        "weather": [
          {
            "id": 801,
            "main": "Clouds",
            "description": "few clouds",
            "icon": "02d"
          }
        ],
        "clouds": {"all": 12},
        "wind": {"speed": 1.44, "deg": 355, "gust": 1.65},
        "visibility": 10000,
        "pop": 0.04,
        "sys": {"pod": "d"},
        "dt_txt": "2024-07-10 18:00:00"
      },
      {
        "dt": 1720645200,
        "main": {
          "temp": 20.99,
          "feels_like": 20.97,
          "temp_min": 20.99,
          "temp_max": 20.99,
          "pressure": 1016,
          "sea_level": 1016,
          "grnd_level": 933,
          "humidity": 70,
          "temp_kf": 0
        },
        "weather": [
          {
            "id": 800,
            "main": "Clear",
            "description": "clear sky",
            "icon": "01n"
          }
        ],
        "clouds": {"all": 0},
        "wind": {"speed": 1.37, "deg": 240, "gust": 1.3},
        "visibility": 10000,
        "pop": 0,
        "sys": {"pod": "n"},
        "dt_txt": "2024-07-10 21:00:00"
      },
      {
        "dt": 1720656000,
        "main": {
          "temp": 19.9,
          "feels_like": 19.85,
          "temp_min": 19.9,
          "temp_max": 19.9,
          "pressure": 1016,
          "sea_level": 1016,
          "grnd_level": 932,
          "humidity": 73,
          "temp_kf": 0
        },
        "weather": [
          {
            "id": 800,
            "main": "Clear",
            "description": "clear sky",
            "icon": "01n"
          }
        ],
        "clouds": {"all": 0},
        "wind": {"speed": 1.72, "deg": 230, "gust": 1.55},
        "visibility": 10000,
        "pop": 0,
        "sys": {"pod": "n"},
        "dt_txt": "2024-07-11 00:00:00"
      },
      {
        "dt": 1720666800,
        "main": {
          "temp": 19.2,
          "feels_like": 19.11,
          "temp_min": 19.2,
          "temp_max": 19.2,
          "pressure": 1015,
          "sea_level": 1015,
          "grnd_level": 931,
          "humidity": 74,
          "temp_kf": 0
        },
        "weather": [
          {
            "id": 800,
            "main": "Clear",
            "description": "clear sky",
            "icon": "01n"
          }
        ],
        "clouds": {"all": 0},
        "wind": {"speed": 1.69, "deg": 222, "gust": 1.54},
        "visibility": 10000,
        "pop": 0,
        "sys": {"pod": "n"},
        "dt_txt": "2024-07-11 03:00:00"
      }
    ],
    "city": {
      "id": 3163858,
      "name": "Zocca",
      "coord": {"lat": 44.34, "lon": 10.99},
      "country": "IT",
      "population": 4593,
      "timezone": 7200,
      "sunrise": 1720237132,
      "sunset": 1720292546
    }
  });
}
