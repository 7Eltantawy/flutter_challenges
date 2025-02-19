part of 'weather_bloc.dart';

sealed class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object> get props => [];
}

final class WeatherInitialState extends WeatherState {}

final class WeatherLoadedState extends WeatherState {
  final WeatherEntity weatherEntity;
  const WeatherLoadedState(this.weatherEntity);
}

final class WeatherLoadingState extends WeatherState {}

final class WeatherErrorState extends WeatherState {
  final String msg;
  const WeatherErrorState(this.msg);
}
