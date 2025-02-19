import 'package:hive/hive.dart';
import 'package:weather_app/features/home/data/models/weather_api_model.dart';

abstract class BaseWeatherLocalDataSource {
  WeatherAPIModel? getWeatherDetails(String cityName);
  Future<void> storeWeatherDetails(WeatherAPIModel weatherAPIModel);
}

class WeatherLocalDataSource extends BaseWeatherLocalDataSource {
  final Box<WeatherAPIModel> weatherBox;

  WeatherLocalDataSource(this.weatherBox);

  @override
  WeatherAPIModel? getWeatherDetails(String cityName) {
    return weatherBox.get(cityName);
  }

  @override
  Future<void> storeWeatherDetails(WeatherAPIModel weatherAPIModel) {
    return weatherBox.put(weatherAPIModel.cityName, weatherAPIModel);
  }
}
