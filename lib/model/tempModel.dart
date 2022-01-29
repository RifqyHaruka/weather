// ignore_for_file: file_names, prefer_typing_uninitialized_variables

class TemperatureModel {
  double? temp;
  double? feelsLike;
  var pressure;
  var humidity;

  TemperatureModel({this.temp, this.feelsLike, this.pressure, this.humidity});

  TemperatureModel.fromJson(Map<String, dynamic> json) {
    temp = json['temp'];
    feelsLike = json['feels_like'];
    pressure = json['pressure'];
    humidity = json['humidity'];
  }

  Map<String, dynamic> toJson() {
    return {
      'temp': temp,
      'feels_like': feelsLike,
      'pressure': pressure,
      'humidity': humidity
    };
  }
}
