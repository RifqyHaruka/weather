// ignore_for_file: file_names

import 'package:weatheria/model/mainWeather.dart';
import 'package:weatheria/model/tempModel.dart';
import 'package:weatheria/model/wind.model.dart';

class WeatherModel {
  String? locationName;
  List<MainWeatherModel>? mainWeather;
  TemperatureModel? temp;
  WindModel? wind;
  int? clouds;
  int? dt;
  double? lon;
  double? lat;

  WeatherModel(
      {this.locationName,
      this.mainWeather,
      this.temp,
      this.wind,
      this.clouds,
      this.lon,
      this.lat
      // this.speed,
      // this.clouds,
      // this.humidity
      });

  WeatherModel.fromJson(Map<String, dynamic> json) {
    locationName = json['name'];
    mainWeather = json['weather']
        .map<MainWeatherModel>((weather) => MainWeatherModel.fromJson(weather))
        .toList();
    temp = TemperatureModel.fromJson(json['main']);
    wind = WindModel.fromJson(json['wind']);
    dt = json['dt'];
    clouds = json['clouds']['all'];
    lon = json['coord']['lon'];
    lat = json['coord']['lat'];
  }

  Map<String, dynamic> toJson() {
    return {
      'name': locationName,
      'weather': mainWeather!.map((weather) => weather.toJson()).toList(),
      'main': temp!.toJson(),
      'wind': wind!.toJson(),
      'dt': dt,
      'all': clouds,
      'lon': lon,
      'lat': lat
    };
  }
}
