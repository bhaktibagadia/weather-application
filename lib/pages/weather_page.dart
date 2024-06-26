import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/services/weather_service.dart';

import '../models/weather_model.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  //api key
  final _weatherService = WeatherService('8719102380d83e9e2652c0f28223fb91');
  Weather? _weather;

  //fetch weather
  _fetchWeather() async {
    String cityName = await _weatherService.getCurrentCity();

    // try {
    //   final weather = await _weatherService.getWeather(cityName);
    //   setState(() {
    //     _weather = weather;
    //   });
    // }
    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print("Error fetching weather: $e");
      // Handle the error gracefully, e.g., show an error message to the user
    }
  }
  //any errors
  //   catch (e) {
  //     print(e);
  //   }
  // }

  //weather animations

  //init state
  @override
  void initState() {
    super.initState();

    _fetchWeather();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(_weather?.cityName ?? "loading city name.."),
          Lottie.asset('assets/cloudy.json.json'),
          Text('${_weather?.temperature.round()}°C')
        ],
      ),
    ));
  }
}
