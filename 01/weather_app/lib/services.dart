import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:weather_app/core/di/dependency_injection.dart'
    as service_locator;
import 'package:weather_app/features/home/data/models/weather_api_model.dart';

Future initServices() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initHive();
  await service_locator.initSL();
}

Future initHive() async {
  await Hive.initFlutter();

  /// Register Adapters
  Hive.registerAdapter(WeatherAPIModelAdapter());
}
