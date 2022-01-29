// ignore_for_file: file_names, avoid_print

import 'package:flutter/cupertino.dart';
import 'package:weatheria/model/cityModel.dart';
import 'package:weatheria/model/forecastModel.dart';

import 'package:weatheria/model/weatherModel.dart';
import 'package:weatheria/service/forecastService.dart';
import 'package:weatheria/service/weatherService.dart';

class WeatherProvider with ChangeNotifier {
  WeatherModel? _weather;

  List<ForecastModel>? _forecast;
  List<CityModel>? _city = [];

  WeatherModel get weather => _weather as WeatherModel;
  List<ForecastModel> get forecast => _forecast as List<ForecastModel>;
  List<CityModel> get city => _city as List<CityModel>;

  set weather(WeatherModel weather) {
    _weather = weather;
    notifyListeners();
  }

  set forecast(List<ForecastModel> forecast) {
    _forecast = forecast;
    notifyListeners();
  }

  set city(List<CityModel> city) {
    _city = city;
    notifyListeners();
  }

  Future<void> getWeather(double lat, double long) async {
    try {
      WeatherModel weather = await WeatherService().getWeather(lat, long);
      _weather = weather;
    } catch (e) {
      print(e);
      print('Salah di Provider');
    }
  }

  Future<void> getCity() async {
    try {
      List<CityModel> city = await WeatherService().getCityJson();
      _city = city;
    } catch (e) {
      print(e);
      print('Salah di City Proivder');
    }
  }

  Future<void> getforecast(var lat, var long) async {
    try {
      List<ForecastModel> forecast =
          await ForecasService().getForecastWeather(lat, long);
      _forecast = forecast;
    } catch (e) {
      Exception(e);
      Exception('Salah di get Forecast provider');
    }
  }

  Future<bool> getWeatherCity(String city) async {
    try {
      WeatherModel weather = await WeatherService().getWeatherCity(city);
      _weather = weather;
      return true;
    } catch (e) {
      print(e);
      print('Salah di Provider');
      return false;
    }
  }
}
