class WeatherModel {
  String? name;
  String? base;
  int? timeZone;
  Coordination? coordination;
  List<Weather>? weather;
  Main? main;
  Wind? wind;
  System? system;

  WeatherModel(
      {this.system,
      this.wind,
      this.main,
      this.weather,
      this.coordination,
      this.name,
      this.base,
      this.timeZone});

  factory WeatherModel.fromJson(Map<String, dynamic> json) => WeatherModel(
      name: json['name'],
      base: json['base'],
      main: Main.fromJson(json['main']),
      system: System.fromJson(json['sys']),
      timeZone: json['timezone'],
      weather:
          List<Weather>.from(json['weather'].map((x) => Weather.fromJson(x))),
      wind: Wind.fromJson(json['wind']),
      coordination: Coordination.fromJson(
        json['coord'],
      ));
}

class Coordination {
  double? latitude;
  double? longitude;
  Coordination({this.latitude, this.longitude});
  factory Coordination.fromJson(Map<String, dynamic> json) =>
      Coordination(latitude: json['latitude'], longitude: json['longitude']);

  Map<String, dynamic> toJson() =>
      {'latitude': latitude, 'longitude': longitude};
}

class Weather {
  String? description;
  String? icon;
  String? condition;
  Weather({this.icon, this.condition, this.description});
  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
      icon: json['icon'],
      condition: json['condition'],
      description: json['description']);
}

class Main {
  double? temp;
  double? feelsLike;
  double? tempMin;
  double? tempMax;
  int? pressure;
  int? humidity;

  Main(
      {this.feelsLike,
      this.humidity,
      this.pressure,
      this.temp,
      this.tempMax,
      this.tempMin});
  factory Main.fromJson(Map<String, dynamic> json) => Main(
        temp: json['temp'],
        feelsLike: json["feels_like"],
        tempMin: json["temp_min"],
        tempMax: json["temp_max"],
        pressure: json["pressure"],
        humidity: json["humidity"],
      );
}

class Wind {
  double? speed;
  int? deg;

  Wind({this.speed, this.deg});
  factory Wind.fromJson(Map<String, dynamic> json) =>
      Wind(deg: json['deg'], speed: json['speed']);
}

class System {
  String? country;
  int? sunrise;
  int? sunset;

  System({this.country, this.sunrise, this.sunset});

  factory System.fromJson(Map<String, dynamic> json) => System(
      country: json["country"],
      sunrise: json["sunrise"],
      sunset: json["sunset"]);
}
