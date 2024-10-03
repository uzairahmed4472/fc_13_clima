import 'dart:convert';

import 'package:clima/screens/city_screen.dart';
import 'package:clima/services/networking.dart';
import 'package:clima/services/weather.dart';
import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';

class LocationScreen extends StatefulWidget {
  final String data;
  LocationScreen({required this.data});
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  int? weatherCondition;
  double? temp;
  String? cityName;
  String? weatherIcon;
  String? message;

  String? getCityName;

  getCityWeather(String city) async {
    var cityWeatherOBJ = Networking(
        "https://api.openweathermap.org/data/2.5/weather?q=$city&units=metric&appid=9d1e7529d24f70e46bb3042b097a05f7");
    var cityResponse = await cityWeatherOBJ.getWeatherData();
    return cityResponse;
  }

  fetchWeatherData(String data) {
    if (data.isNotEmpty) {
      // openAPI data
      setState(() {
        var weatherDataJson = jsonDecode(data);
        weatherCondition = weatherDataJson["weather"][0]["id"];
        temp = weatherDataJson["main"]["temp"];
        cityName = weatherDataJson['name'];
        weatherIcon = weatherObject.getWeatherIcon(weatherCondition!);
        message = weatherObject.getMessage(temp!.round());
      });
    } else {
      // local data
      setState(() {
        weatherCondition = 0;
        temp = 0;
        cityName = "";
        weatherIcon = "Error";
        message = "No Data";
      });
    }
  }

  @override
  void initState() {
    super.initState();
    String dataFromLoading = widget.data;

    fetchWeatherData(dataFromLoading!);
    print(getCityName);
  }

  @override
  Widget build(BuildContext context) {
    // print(getCityName);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: () {},
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      getCityName = await Navigator.push(context,
                          MaterialPageRoute(builder: (contexr) {
                        return CityScreen();
                      }));

                      var cityName = await getCityWeather(getCityName!);

                      fetchWeatherData(cityName);
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '${temp!.round()}°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      '$weatherIcon',
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  "$message $cityName",
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
