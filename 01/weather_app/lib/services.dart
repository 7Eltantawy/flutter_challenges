import 'package:flutter/material.dart';
import 'package:weather_app/core/di/dependency_injection.dart'
    as service_locator;

Future initServices() async {
  WidgetsFlutterBinding.ensureInitialized();

  await service_locator.initSL();
}
