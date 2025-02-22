import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/core/extensions/double_extension.dart';

void main() {
  group("Kelvin to Celsius", () {
    test('Given 273.15 in kelvin, should return the 0 in celsius', () {
      final result = 273.15.kelvinToCelsius();
      expect(result, 0);
    });

    test('Given 300.15 in kelvin, should return the 27.0 in celsius', () {
      final result = 300.15.kelvinToCelsius();
      expect(result, 27.0);
    });
  });
}
