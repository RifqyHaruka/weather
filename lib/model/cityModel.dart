// ignore_for_file: file_names, prefer_typing_uninitialized_variables

class CityModel {
  var id;
  String? name;
  double? lat;
  double? lon;

  CityModel({this.id, this.name});

  CityModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    lat = json['coord']['lat'];
    lon = json['coord']['lon'];
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'lat': lat, 'lon': lon};
  }
}
