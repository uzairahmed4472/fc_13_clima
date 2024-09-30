import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:clima/screens/location_screen.dart';
import 'package:http/http.dart' as http;

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  //TODO 01 get data from internet
  Future<dynamic> getWeatherData() async {
    // var weatherData
    final request = await http.get(Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?lat=44.34&lon=10.99&units=metric&appid=9d1e7529d24f70e46bb3042b097a05f7"));

    if (request.statusCode == 200) {
      var response = request.body;
      var data = jsonDecode(response);
      // return response;
    } else {
      print('Error');
    }
  }

  fetchAll() async {
    dynamic weatherData = await getWeatherData();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return LocationScreen(data: weatherData);
      }),
    );
  }

  @override
  void initState() {
    fetchAll();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}

      // var weatherCode = weatherData["weather"][0]["id"];
      // var temp = weatherData["main"]["temp"];
      // var cityName = weatherData["name"];