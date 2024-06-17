import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/model/weather_model.dart';

class WeatherService {
  static final dio = Dio();
  static String weatherURL = "https://api.openweathermap.org/data/2.5/weather";
  static String forecastURL = "http://api.openweathermap.org/data/2.5/forecast";

  static getWeatherBySearch(String place) async {
    var data = {'q': place, 'appid': dotenv.env["api_key"], 'units': 'metric'};
    final response = await dio.get(weatherURL, queryParameters: data);
    if (response.data['cod'] == 200) {
      return WeatherModel.fromJson(response.data);
    }
  }

  static getCurrentWeather(Position position) async {
    var data = {
      'lat': position.latitude,
      'lon': position.longitude,
      'appid': dotenv.env["api_key"],
      'units': 'metric'
    };
    final response = await dio.get(weatherURL, queryParameters: data);
    if (response.data['cod'] == 200) {
      return WeatherModel.fromJson(response.data);
    }
  }

  static getWeatherForecast() async {
    var data = {'appid': dotenv.env["api_key"], 'units': 'metric'};
    final response = await dio.get(weatherURL, queryParameters: data);
    if (response.data['cod'] == 200) {
      return WeatherModel.fromJson(response.data);
    }
  }
}
//http://api.openweathermap.org/data/2.5/forecast?id=524901&appid={API key}
