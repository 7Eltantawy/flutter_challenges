import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_app/core/error/failure.dart';
import 'package:weather_app/features/home/data/data_source/weather_remote_local_source.dart';
import 'package:weather_app/features/home/data/models/weather_api_model.dart';
import 'package:weather_app/features/home/domain/entities/weather_entity.dart';
import 'package:weather_app/features/home/domain/use_cases/get_weather_details.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final GetWeatherDetailsUseCase getWeatherDetailsUseCase;
  final BaseWeatherLocalDataSource localDataSource;

  WeatherBloc(this.getWeatherDetailsUseCase, this.localDataSource)
      : super(WeatherInitialState()) {
    on<GetWeatherDetailsEvent>(_getWeatherDetails);
  }

  FutureOr<void> _getWeatherDetails(
    GetWeatherDetailsEvent event,
    Emitter<WeatherState> emit,
  ) async {
    emit(WeatherLoadingState());
    final result = await getWeatherDetailsUseCase(event.cityName);
    final cachedWeather = localDataSource.getWeatherDetails(event.cityName);
    result.fold((l) {
      emit(WeatherErrorState(l));
    }, (r) async {
      emit(WeatherLoadedState(r, cachedWeather ?? r));
      await localDataSource.storeWeatherDetails(r as WeatherAPIModel);
    });
  }
}
