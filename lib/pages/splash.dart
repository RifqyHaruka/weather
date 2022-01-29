// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:weatheria/pages/home.dart';
import 'package:weatheria/provider/locationProvider.dart';
import 'package:weatheria/provider/weatherProvider.dart';
import 'package:weatheria/theme.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  Position? currentLocation;

  @override
  void initState() {
    getCity();
    getLocation();
    super.initState();
  }

  // Future<Position> locateUser() async {
  //   return Geolocator.getCurrentPosition(
  //       desiredAccuracy: LocationAccuracy.high);
  // }

  getLocation() async {
    await Provider.of<LocationProvider>(context, listen: false)
        .getCurrentLocation();

    var lat = Provider.of<LocationProvider>(context, listen: false)
        .currentLocation
        .latitude;
    var long = Provider.of<LocationProvider>(context, listen: false)
        .currentLocation
        .longitude;

    await Provider.of<WeatherProvider>(context, listen: false)
        .getWeather(lat, long);
    await Provider.of<WeatherProvider>(context, listen: false)
        .getforecast(lat, long);

    // Navigator.push(
    //     context, MaterialPageRoute(builder: (context) => HomePage()));
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => HomePage()), (route) => false);
  }

  getCity() async {
    await Provider.of<WeatherProvider>(context, listen: false).getCity();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/splash.png',
              width: 200,
              height: 200,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Weatheria',
              style: mainTextStyle.copyWith(
                  fontSize: 22, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 20,
            ),
            CircularProgressIndicator()
          ],
        ),
      ),
    );
  }
}
