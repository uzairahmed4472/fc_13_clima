import 'dart:convert';

import 'package:clima/screens/city_screen.dart';
import 'package:clima/screens/location_screen.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  getData() async {
    Response request = await get(
      Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?lat=34.01&lon=71.52&units=metric&appid=9d1e7529d24f70e46bb3042b097a05f7#'),
    );
    if (request.statusCode == 200) {
      var response = request.body.toString();
      
      Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LocationScreen()
      ),
    );
     
    } else {
      print("Error");
      return "";
    }
  }

  @override
  void initState() {
    getData();
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
