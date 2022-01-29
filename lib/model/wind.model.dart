class WindModel {
  double? speed;

  WindModel({this.speed});

  WindModel.fromJson(Map<String, dynamic> json) {
    speed = json['speed'];
  }

  Map<String, dynamic> toJson() {
    return {'speed': speed};
  }
}
