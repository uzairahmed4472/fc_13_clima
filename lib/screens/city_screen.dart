import 'package:clima/screens/location_screen.dart';
import 'package:clima/services/location.dart';
import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:geolocator/geolocator.dart';

class CityScreen extends StatefulWidget {
  @override
  _CityScreenState createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  @override
  void initState() {
    print("init runs");
    var parseLocation = Location();
    parseLocation.determinePosition();
    super.initState();
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    print("deactivate runs");
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    print("build runs");
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/city_background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: TextButton(
                  onPressed: () {},
                  child: Icon(
                    Icons.arrow_back_ios,
                    size: 50.0,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(20.0),
                child: null,
              ),
              TextField(
                
                style: TextStyle(
                  
                  fontWeight: FontWeight.bold,
                ),
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.green,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.red,
                      ),
                    ),
                    label: Text("data"),
                    hintText: "DATAAA"),
                onChanged: (value) {
                  print(value);
                },
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return LocationScreen();
                      },
                    ),
                  );
                },
                child: Text(
                  'Get Weather',
                  style: kButtonTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
