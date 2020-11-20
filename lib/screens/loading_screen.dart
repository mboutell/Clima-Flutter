import 'package:clima/screens/location_screen.dart';
import 'package:clima/services/location.dart';
import 'package:clima/services/weather.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  LocationManager locationManager;
  WeatherManager weatherManager;

  @override
  void initState() {
    super.initState();
    print("init state");
    getLocation();
  }

  void getLocation() async {
    LocationManager().startListening(() async {
      // print(
      //     "clbk location is (${LocationManager().latitude}, ${LocationManager().longitude})");
      await WeatherManager().updateWeather(
          LocationManager().latitude, LocationManager().longitude);
      LocationManager().stopListening();
      Navigator.pushNamed(context, "/location");
    });
  }

  @override
  void deactivate() {
    super.deactivate();
    print("deactivate");
  }

  void buttonAction() async {
    // Position position = await Geolocator.getCurrentPosition(
    //     desiredAccuracy: LocationAccuracy.low);
    // print(position);
    // _getBookInfo();
    // _getWeather();

    // print(weatherManager.getMessage());
    // print(weatherManager.getWeatherIcon());
    // Navigator.push(context, MaterialPageRoute(builder: (context) {
    //   return LocationScreen();
    // }));
  }

// 39.467076, -87.403523

  void _getWeather() async {
    var url =
        'http://api.openweathermap.org/data/2.5/weather?units=imperial&lat=39.467076&lon=-87.403523&APPID=e58f2596eedb38a4a4486d11c8f27e66';
    // Await the http get response, then decode the json-formatted response.
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      // var itemCount = jsonResponse['totalItems'];
      print(jsonResponse);
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  Future<void> _getBookInfo() async {
    var url = 'https://www.googleapis.com/books/v1/volumes?q={http}';
    // Await the http get response, then decode the json-formatted response.
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      var itemCount = jsonResponse['totalItems'];
      print('Number of books about http: $itemCount.');
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  @override
  Widget build(BuildContext context) {
    print("build");
    return Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.white,
          size: 100,
        ),
      ),
    );
  }
}
