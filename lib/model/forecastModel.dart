// ignore_for_file: file_names, prefer_typing_uninitialized_variables
import 'package:weatheria/model/mainWeather.dart';

class ForecastModel {
  var dt;
  double? temp;
  double? windspeed;
  var clouds;
  double? rain;
  List<MainWeatherModel>? weather;

  ForecastModel({this.dt, this.temp, this.clouds, this.rain, this.weather});

  ForecastModel.fromJson(Map<String, dynamic> json) {
    dt = json['dt'];
    windspeed = json['wind_speed'];
    temp = json['temp']['day'];
    clouds = json['clouds'];
    rain = json['rain'];
    weather = json['weather']
        .map<MainWeatherModel>((weather) => MainWeatherModel.fromJson(weather))
        .toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'dt': dt,
      'temp': temp,
      'winds': windspeed,
      'clouds': clouds,
      'rain': rain,
      'weather': weather!.map((weather) => weather.toJson()).toList(),
    };
  }
}
