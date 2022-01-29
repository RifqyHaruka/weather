// ignore_for_file: unused_import, file_names

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weatheria/model/forecastModel.dart';

class ForecasService {
  Future<List<ForecastModel>> getForecastWeather(
      double lat, double long) async {
    var apiKey = '333ae8a687035bbe74d1af6b1171aace';
    var lang = 'id';
    var temp = 'metric';

    var url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/onecall?lat=$lat&lon=$long&exclude=minutely,hourly,alerts&appid=$apiKey&units=$temp&lang=$lang');

    var response = await http.get(url);

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body)['daily'];
      List<ForecastModel> forecast = [];
      for (var item in data) {
        forecast.add(ForecastModel.fromJson(item));
      }

      return forecast;
    } else {
      throw Exception('Salah Di Service Get Forecast');
    }
  }
}
