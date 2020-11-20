import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class WeatherManager {
  static const String key = "e58f2596eedb38a4a4486d11c8f27e66";
  // double lat = 39.467076;
  // double lon = -87.403523;

  static final WeatherManager _instance = WeatherManager._privateConstructor();

  factory WeatherManager() {
    return _instance;
  }

  WeatherManager._privateConstructor();

  double temperature;
  int condition;
  String cityName;

  Future<void> updateWeather(lat, lon) async {
    var url =
        'http://api.openweathermap.org/data/2.5/weather?units=metric&lat=$lat&lon=$lon&APPID=$key';
    // Await the http get response, then decode the json-formatted response.
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      print(jsonResponse);
      condition = jsonResponse["weather"][0]["id"];
      temperature = jsonResponse["main"]["temp"].toDouble();
      cityName = jsonResponse["name"];
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  Future<void> updateWeatherForCity(String cityName) async {
    var url =
        'http://api.openweathermap.org/data/2.5/weather?units=metric&q=$cityName&APPID=$key';
    // Await the http get response, then decode the json-formatted response.
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      print(jsonResponse);
      condition = jsonResponse["weather"][0]["id"];
      temperature = jsonResponse["main"]["temp"].toDouble();
      cityName = jsonResponse["name"];
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  String getWeatherIcon() {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage() {
    if (temperature > 25) {
      return 'It\'s 🍦 time';
    } else if (temperature > 20) {
      return 'Time for shorts and 👕';
    } else if (temperature < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
