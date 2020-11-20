import 'package:clima/screens/city_screen.dart';
import 'package:clima/screens/location_screen.dart';
import 'package:flutter/material.dart';
import 'package:clima/screens/loading_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      initialRoute: "/loading",
      routes: {
        "/loading": (context) => LoadingScreen(),
        "/location": (context) => LocationScreen(),
        "/city": (context) => CityScreen(),
      },
    );
  }
}
