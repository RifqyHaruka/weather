// ignore_for_file: file_names, prefer_const_constructors, duplicate_ignore, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, sized_box_for_whitespace
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weatheria/model/forecastModel.dart';
import 'package:weatheria/theme.dart';

class Forecast extends StatefulWidget {
  final ForecastModel forecast;
  final int index;

  Forecast(this.forecast, this.index);
  @override
  _ForecastState createState() => _ForecastState();
}

class _ForecastState extends State<Forecast> {
  bool isSelect = false;
  bool isMerenggang = false;
  double width = 80;
  double height = 150;
  ForecastModel? forecast;
  Color color = white;
  @override
  Widget build(BuildContext context) {
    return (widget.index == 0)
        ? Container()
        : GestureDetector(
            onTap: () {
              setState(() {
                isSelect = !isSelect;
                isMerenggang = false;
                if (isSelect == false) {
                  width = 80;
                  height = 150;
                  color = white;
                } else {
                  width = 200;
                  height = 160;
                  color = Color(0xffB0D6FC);
                  Timer(Duration(seconds: 2), () {
                    setState(() {
                      isMerenggang = !isMerenggang;
                    });
                  });
                }
              });
            },
            child: AnimatedContainer(
                duration: Duration(seconds: 1),
                margin:
                    EdgeInsets.only(top: 30, left: 10, right: 10, bottom: 10),
                height: height,
                width: width,
                decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(40),
                    boxShadow: [
                      BoxShadow(
                          color: white.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(3, 0))
                    ]),
                child: (isSelect == false)
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            DateFormat('EEEE').format(
                                DateTime.fromMillisecondsSinceEpoch(
                                    widget.forecast.dt! * 1000))[0],
                            style: secondaryTextStyle.copyWith(
                                fontSize: 15, fontWeight: FontWeight.w800),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage((widget.forecast
                                                      .weather![0].id! >=
                                                  200 &&
                                              widget.forecast.weather![0].id! <
                                                  300)
                                          ? 'assets/thunderstrom.png'
                                          : (widget.forecast.weather![0].id! >= 300 &&
                                                  widget.forecast.weather![0].id! <
                                                      500)
                                              ? 'assets/awan.png'
                                              : (widget.forecast.weather![0].id! >= 500 &&
                                                      widget.forecast.weather![0].id! <
                                                          600)
                                                  ? 'assets/hujan.png'
                                                  : (widget.forecast.weather![0].id! >= 600 &&
                                                          widget
                                                                  .forecast
                                                                  .weather![0]
                                                                  .id! <
                                                              700)
                                                      ? 'assets/snow.png'
                                                      : (widget.forecast.weather![0].id! >= 700 &&
                                                              widget.forecast.weather![0].id! <
                                                                  800)
                                                          ? 'assets/mist.png'
                                                          : (widget.forecast.weather![0].id! >=
                                                                      800 &&
                                                                  widget.forecast.weather![0].id! <= 804)
                                                              ? 'assets/clouds.png'
                                                              : 'assets/awan.png'),
                                      fit: BoxFit.contain))),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            '${widget.forecast.temp} \u2103',
                            style: mainTextStyle.copyWith(
                                fontSize: 10, fontWeight: FontWeight.w900),
                          ),
                        ],
                      )
                    : (isMerenggang == false)
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    DateFormat('EEEE').format(
                                        DateTime.fromMillisecondsSinceEpoch(
                                            widget.forecast.dt! * 1000))[0],
                                    style: secondaryTextStyle.copyWith(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w800),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                      height: 40,
                                      width: 40,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage((widget
                                                              .forecast
                                                              .weather![0]
                                                              .id! >=
                                                          200 &&
                                                      widget.forecast.weather![0].id! <
                                                          300)
                                                  ? 'assets/thunderstrom.png'
                                                  : (widget.forecast.weather![0].id! >=
                                                              300 &&
                                                          widget
                                                                  .forecast
                                                                  .weather![0]
                                                                  .id! <
                                                              500)
                                                      ? 'assets/awan.png'
                                                      : (widget.forecast.weather![0].id! >=
                                                                  500 &&
                                                              widget.forecast.weather![0].id! <
                                                                  600)
                                                          ? 'assets/hujan.png'
                                                          : (widget.forecast.weather![0].id! >=
                                                                      600 &&
                                                                  widget.forecast.weather![0].id! <
                                                                      700)
                                                              ? 'assets/snow.png'
                                                              : (widget.forecast.weather![0].id! >=
                                                                          700 &&
                                                                      widget.forecast.weather![0].id! < 800)
                                                                  ? 'assets/mist.png'
                                                                  : (widget.forecast.weather![0].id! >= 800 && widget.forecast.weather![0].id! <= 804)
                                                                      ? 'assets/clouds.png'
                                                                      : 'assets/awan.png'),
                                              fit: BoxFit.contain))),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    '${widget.forecast.temp} \u2103',
                                    style: mainTextStyle.copyWith(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w900),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(right: 20, top: 10),
                                    child: Row(
                                      children: [
                                        Container(
                                          height: 40,
                                          width: 40,
                                          child:
                                              Image.asset('assets/windy.png'),
                                        ),
                                        Text(
                                          '${widget.forecast.windspeed} km/h \n Wind Speed',
                                          textAlign: TextAlign.center,
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(right: 20, top: 10),
                                    child: Row(
                                      children: [
                                        Container(
                                          height: 40,
                                          width: 40,
                                          child:
                                              Image.asset('assets/cloudy.png'),
                                        ),
                                        Text(
                                          '${widget.forecast.clouds} % \n Cloudiness',
                                          textAlign: TextAlign.center,
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                        right: 20, top: 10, bottom: 10),
                                    child: Row(
                                      children: [
                                        Container(
                                          height: 40,
                                          width: 40,
                                          child:
                                              Image.asset('assets/windy.png'),
                                        ),
                                        Text(
                                          '${widget.forecast.rain} km/h \n Rain',
                                          textAlign: TextAlign.center,
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              )
                            ],
                          )),
          );
  }
}
