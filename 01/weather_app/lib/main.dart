import 'package:flutter/material.dart';
import 'package:weather_app/app.dart';
import 'package:weather_app/services.dart';

Future main() async {
  await initServices();
  runApp(const WeatherApp());
}
