import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/features/home/data/models/weather_api_model.dart';
import 'package:weather_app/features/home/domain/entities/weather_entity.dart';

import '../../../../dummy/weather_api_response.dart';

void main() {
  final testWeatherAPIModel = WeatherAPIModel(
    cityName: "Cairo",
    temperature: 287.57,
    humidity: 88,
    windSpeed: 2.06,
  );
  group("WeatherAPIModel", () {
    test("Should be a subclass of WeatherEntity", () {
      expect(testWeatherAPIModel, isA<WeatherEntity>());
    });

    test("Should correctly parse json", () {
      final result = WeatherAPIModel.fromJson(dummyApiResponse);
      expect(result, equals(testWeatherAPIModel));
    });

    test("Should correctly convert model to json map", () {
      final result = testWeatherAPIModel.toMap();
      const Map<String, dynamic> expectedMap = {
        'name': "Cairo",
        'main': {'temp': 287.57, 'humidity': 88},
        'wind': {'speed': 2.06},
      };
      expect(result, equals(expectedMap));
    });
  });
}
