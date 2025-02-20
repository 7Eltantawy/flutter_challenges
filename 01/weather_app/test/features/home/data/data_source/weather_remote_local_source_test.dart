import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app/features/home/data/data_source/weather_remote_local_source.dart';
import 'package:weather_app/features/home/data/models/weather_api_model.dart';

import '../../../../mocks/mock_classes.dart';

void main() {
  late MockWeatherBox mockHiveBox;
  late WeatherLocalDataSource weatherLocalDataSource;

  setUp(() async {
    mockHiveBox = MockWeatherBox();
    weatherLocalDataSource = WeatherLocalDataSource(mockHiveBox);
  });

  group("Get weather details from cache", () {
    final String cityName = "Cairo";
    final weatherAPIModel = WeatherAPIModel(
      cityName: cityName,
      temperature: 287.57,
      humidity: 88,
      windSpeed: 2.06,
    );

    test("Should cache WeatherEntity", () {
      /// ARRANGE
      when(mockHiveBox.get(cityName)).thenReturn(weatherAPIModel);

      /// ACT
      final result = weatherLocalDataSource.getWeatherDetails(cityName);

      /// ASSERT
      expect(result, equals(weatherAPIModel));
      verify(weatherLocalDataSource.getWeatherDetails(cityName)).called(1);
    });

    test("Should return null when there is no cached data", () {
      /// ARRANGE
      when(mockHiveBox.get(cityName)).thenReturn(null);

      /// ACT
      final result = weatherLocalDataSource.getWeatherDetails(cityName);

      /// ASSERT
      expect(result, equals(null));
      verify(weatherLocalDataSource.getWeatherDetails(cityName)).called(1);
    });

    test("Should return weather from cache", () {
      /// ARRANGE
      when(mockHiveBox.get(cityName)).thenReturn(weatherAPIModel);

      /// ACT
      final result = weatherLocalDataSource.getWeatherDetails(cityName);

      /// ASSERT
      expect(result, equals(weatherAPIModel));
      verify(weatherLocalDataSource.getWeatherDetails(cityName)).called(1);
    });
  });
}
