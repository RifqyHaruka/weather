// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:weatheria/pages/search.dart';
import 'package:weatheria/provider/locationProvider.dart';
import 'package:weatheria/provider/weatherProvider.dart';
import 'package:weatheria/theme.dart';
import 'package:weatheria/widget/weatherForecast.dart';
import 'package:collection/collection.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var weatherProvider = Provider.of<WeatherProvider>(context);
    var getLocation = Provider.of<LocationProvider>(context);

    getWeather() async {
      await weatherProvider.getWeather(getLocation.currentLocation.latitude,
          getLocation.currentLocation.longitude);
    }

    Widget header() {
      return Container(
        margin: EdgeInsets.only(left: 20, top: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  weatherProvider.weather.locationName as String,
                  style: mainTextStyle.copyWith(
                      fontSize: 20, fontWeight: FontWeight.w800),
                ),
                SizedBox(
                  height: 4,
                ),
                Text(
                  DateFormat('EEEE,  h:mm a').format(
                      DateTime.fromMillisecondsSinceEpoch(
                          weatherProvider.weather.dt! * 1000)),
                  style: secondaryTextStyle.copyWith(
                      color: secondaryColor,
                      fontSize: 15,
                      fontWeight: FontWeight.w700),
                )
              ],
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Search()));
              },
              child: Container(
                margin: EdgeInsets.only(right: 20),
                child: Image.asset(
                  'assets/search.png',
                  width: 30,
                  height: 30,
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget weather() {
      return Center(
        child: Container(
          margin: EdgeInsets.only(top: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  // print(getLocation.currentLocation.latitude);
                  // print(getLocation.currentLocation.longitude);

                  getWeather();
                },
                child: Container(
                  width: 180,
                  height: 180,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage((weatherProvider.weather.mainWeather![0].id! >= 200 &&
                                  weatherProvider.weather.mainWeather![0].id! <
                                      300)
                              ? 'assets/thunderstrom.png'
                              : (weatherProvider.weather.mainWeather![0].id! >= 300 &&
                                      weatherProvider.weather.mainWeather![0].id! <
                                          500)
                                  ? 'assets/awan.png'
                                  : (weatherProvider.weather.mainWeather![0].id! >= 500 &&
                                          weatherProvider.weather.mainWeather![0].id! <
                                              600)
                                      ? 'assets/hujan.png'
                                      : (weatherProvider.weather.mainWeather![0].id! >= 600 &&
                                              weatherProvider.weather.mainWeather![0].id! <
                                                  700)
                                          ? 'assets/snow.png'
                                          : (weatherProvider.weather.mainWeather![0].id! >= 700 &&
                                                  weatherProvider.weather
                                                          .mainWeather![0].id! <
                                                      800)
                                              ? 'assets/mist.png'
                                              : (weatherProvider.weather.mainWeather![0].id! >= 800 &&
                                                      weatherProvider
                                                              .weather
                                                              .mainWeather![0]
                                                              .id! <=
                                                          804)
                                                  ? 'assets/clouds.png'
                                                  : 'assets/awan.png'),
                          fit: BoxFit.contain)),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                '${weatherProvider.weather.mainWeather![0].description}',
                style: mainTextStyle.copyWith(
                    fontSize: 20, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                '${weatherProvider.weather.temp!.temp} \u2103',
                style: mainTextStyle.copyWith(
                    fontSize: 50, fontWeight: FontWeight.w900),
              ),
              SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 40,
                        width: 40,
                        child: Image.asset('assets/windy.png'),
                      ),
                      Text(
                        '${weatherProvider.weather.wind!.speed} km/h \n Wind Speed',
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 40,
                        width: 40,
                        child: Image.asset('assets/cloudy.png'),
                      ),
                      Text(
                        '${weatherProvider.weather.clouds} % \n Cloudiness',
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 40,
                        width: 40,
                        child: Image.asset('assets/rain.png'),
                      ),
                      Text(
                        '1.5 km/h \n Rain',
                        textAlign: TextAlign.center,
                      )
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      );
    }

    Widget forecastWeather() {
      return Container(
        margin: EdgeInsets.only(top: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                'Daily Forecast 7 Days',
                style: mainTextStyle.copyWith(
                    fontSize: 20, fontWeight: FontWeight.w800),
              ),
            ),
            SizedBox(
              height: 4,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                'Provide You With Forecast For Next 7 Days',
                style: secondaryTextStyle.copyWith(
                    color: secondaryColor,
                    fontSize: 15,
                    fontWeight: FontWeight.w700),
              ),
            ),
            // Unfortunately cant find free forecast weather API
            // So i did it Manually
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                  children: weatherProvider.forecast
                      .mapIndexed(
                          (index, forecast) => Forecast(forecast, index))
                      .toList()),
            )
          ],
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [white, gradasi1],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter)),
      child: SafeArea(
        child: Scaffold(
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [header(), weather(), forecastWeather()],
              ),
            )),
      ),
    );
  }
}
