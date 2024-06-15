import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weather_app/model/weather_model.dart';

class WeatherService {
  static final dio = Dio();
  static String weatherURL = "https://api.openweathermap.org/data/2.5/weather";

  static getWeather() async {
    var data = {
      'q': 'mysore',
      'appid': dotenv.env["api_key"],
      'units': 'metric'
    };
    final response = await dio.get(weatherURL, queryParameters: data);
    if (response.data['cod'] == 200) {
      return WeatherModel.fromJson(response.data);
    }
  }
}
