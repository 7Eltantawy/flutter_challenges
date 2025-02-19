part of 'weather_bloc.dart';

sealed class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object> get props => [];
}

final class WeatherInitialState extends WeatherState {}

final class WeatherLoadedState extends WeatherState {
  final WeatherEntity weatherEntity;
  final WeatherEntity cachedWeatherEntity;
  const WeatherLoadedState(this.weatherEntity, this.cachedWeatherEntity);

  @override
  List<Object> get props => [weatherEntity, cachedWeatherEntity];
}

final class WeatherLoadingState extends WeatherState {}

final class WeatherErrorState extends WeatherState {
  final Failure failure;
  const WeatherErrorState(this.failure);

  @override
  List<Object> get props => [failure];
}
