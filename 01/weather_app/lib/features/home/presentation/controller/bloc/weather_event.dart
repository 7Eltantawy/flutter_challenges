part of 'weather_bloc.dart';

sealed class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object> get props => [];
}

class GetWeatherDetailsEvent extends WeatherEvent {
  final String cityName;
  const GetWeatherDetailsEvent(this.cityName);

  @override
  List<Object> get props => [cityName];
}
