// ignore_for_file: file_names, avoid_print

import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:weatheria/model/cityModel.dart';
import 'package:weatheria/model/weatherModel.dart';

class WeatherService {
  var apiKey = '333ae8a687035bbe74d1af6b1171aace';
  var lang = 'id';
  var temp = 'metric';
  Future<WeatherModel> getWeather(double lat, double long) async {
    var url = Uri.parse(
        'http://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$long&appid=$apiKey&units=$temp&lang=$lang');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      WeatherModel weather = WeatherModel.fromJson(data);

      return weather;
    } else {
      throw Exception('Salah di Service Get Weather');
    }
  }

  Future<List<CityModel>> getCityJson() async {
    String response = await rootBundle.loadString('assets/city.json');

    var data = await jsonDecode(response);
    List<CityModel> city = [];
    for (var item in data) {
      city.add(CityModel.fromJson(item));
    }

    return city;
  }

  Future<WeatherModel> getWeatherCity(String city) async {
    var url = Uri.parse(
        'http://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=$temp&lang=$lang');
    var response = await http.get(url);
    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      WeatherModel weather = WeatherModel.fromJson(data);

      return weather;
    } else {
      throw Exception('Salah di Service Get Weather by City');
    }
  }
}
