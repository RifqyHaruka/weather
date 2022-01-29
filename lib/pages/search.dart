// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:clickable_list_wheel_view/clickable_list_wheel_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatheria/model/cityModel.dart';
import 'package:weatheria/pages/lastSearch.dart';
import 'package:weatheria/provider/weatherProvider.dart';
import 'package:weatheria/theme.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController searchController = TextEditingController(text: '');
  List<CityModel> _foundCity = [];
  FixedExtentScrollController? controller;
  bool isLoading = false;
  @override
  void initState() {
    _foundCity = Provider.of<WeatherProvider>(context, listen: false).city;
    super.initState();
    controller = FixedExtentScrollController();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    searchController.dispose();
    super.dispose();
  }

  runFilter(String enteredKeyword) {
    List<CityModel> results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = Provider.of<WeatherProvider>(context, listen: false).city;
    } else {
      results = Provider.of<WeatherProvider>(context, listen: false)
          .city
          .where((city) =>
              city.name!.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }

    setState(() {
      _foundCity = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    var weatherProvider = Provider.of<WeatherProvider>(context);

    cari() async {
      setState(() {
        isLoading = true;
      });

      if (await weatherProvider.getWeatherCity(searchController.text) == true) {
        await weatherProvider.getforecast(
            weatherProvider.weather.lat, weatherProvider.weather.lon);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SearchPage()));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Color(0xffF0D500),
            content: Text(
              'Maaf Kota Yang Anda Cari Belum Terdaftar',
              style: whiteTextStyle,
              textAlign: TextAlign.center,
            )));
      }

      setState(() {
        isLoading = false;
      });
    }

    Widget city(String text) {
      return Container(
        width: MediaQuery.of(context).size.width - 60,
        height: 40,
        color: gradasi1,
        child: Center(
          child: Text(
            text,
            style: mainTextStyle,
          ),
        ),
      );
    }

    Widget search() {
      return Container(
        margin: EdgeInsets.only(top: 100, left: 30, right: 30),
        width: MediaQuery.of(context).size.width - 60,
        height: 50,
        decoration: BoxDecoration(
            color: gradasi2,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white)),
        child: Row(
          children: [
            Expanded(
                child: TextFormField(
              controller: searchController,
              onChanged: (value) {
                runFilter(value);
              },
              style: whiteTextStyle.copyWith(fontSize: 16),
              decoration: InputDecoration(
                hintText: 'Cari Kota',
                hintStyle: whiteTextStyle.copyWith(fontSize: 16),
                contentPadding: EdgeInsets.only(bottom: 5, left: 20),
                border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(20)),
              ),
            )),
          ],
        ),

        // child: TextFormField(
        //   decoration: InputDecoration(
        //       filled: true,
        //       enabledBorder: OutlineInputBorder(
        //           borderRadius: BorderRadius.circular(20),
        //           borderSide: BorderSide.none),
        //       focusedBorder: OutlineInputBorder(
        //           borderRadius: BorderRadius.circular(20),
        //           borderSide: BorderSide(color: border)),
        //       border:
        //           OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        //       contentPadding: EdgeInsets.only(left: 28, bottom: 20, top: 20)),
        // ),
      );
    }

    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [white, gradasi1],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter)),
        child: Scaffold(
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    search(),
                    Container(
                      height: 500,
                      child: (_foundCity.isNotEmpty)
                          ? ClickableListWheelScrollView(
                              scrollController: controller as ScrollController,
                              itemHeight: 80,
                              itemCount: _foundCity.length,
                              onItemTapCallback: (index) async {
                                await weatherProvider.getWeather(
                                    _foundCity[index].lat as double,
                                    _foundCity[index].lon as double);
                                await weatherProvider.getforecast(
                                    _foundCity[index].lat as double,
                                    _foundCity[index].lon as double);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SearchPage()));
                              },
                              child: ListWheelScrollView.useDelegate(
                                  controller: controller as ScrollController,
                                  itemExtent: 80,
                                  physics: FixedExtentScrollPhysics(),
                                  childDelegate: ListWheelChildBuilderDelegate(
                                      childCount: _foundCity.length,
                                      builder: (context, index) {
                                        return city(
                                            '${_foundCity[index].name}');
                                      })),
                              // child: ListWheelScrollView(
                              //   controller: FixedExtentScrollController(),
                              //   itemExtent: 80,
                              //   diameterRatio: 2,
                              //   children: List.generate(
                              //       _foundCity.length,
                              //       (index) =>
                              //           (city('${_foundCity[index].name}'))),
                              // )
                            )
                          // ListWheelScrollView(
                          //     itemExtent: 80,
                          //     diameterRatio: 2,
                          //     children: List.generate(
                          //         _foundCity.length,
                          //         (index) => GestureDetector(
                          //             onTap: () {
                          //               print(index);
                          //             },
                          //             child:
                          //                 (city('${_foundCity[index].name}')))),
                          //   )
                          : Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Kota yang anda cari tidak ada dalam list ???\n Coba click cari',
                                    style: mainTextStyle,
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      cari();
                                    },
                                    child: Container(
                                      child: Center(
                                          child: (isLoading == false)
                                              ? Text(
                                                  'Cari',
                                                  style: whiteTextStyle,
                                                )
                                              : CircularProgressIndicator(
                                                  strokeWidth: 2,
                                                )),
                                      width: 180,
                                      height: 50,
                                      decoration: BoxDecoration(
                                          color: mainTextColor,
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                    ),
                                  )
                                ],
                              ),
                            ),
                    ),
                  ],
                ),
              ),
            )
            // Column(
            //   children: List.generate(
            //       20, (index) => (Text('${cityProvider.city[index].name}'))),
            // ),
            ),
      ),
    );
  }
}
