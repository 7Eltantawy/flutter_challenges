import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_app/core/error/failure.dart';
import 'package:weather_app/features/home/domain/entities/weather_entity.dart';
import 'package:weather_app/features/home/domain/use_cases/get_weather_details.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final GetWeatherDetailsUseCase getWeatherDetailsUseCase;

  WeatherBloc(this.getWeatherDetailsUseCase) : super(WeatherInitialState()) {
    on<GetWeatherDetailsEvent>(_getWeatherDetails);
  }

  FutureOr<void> _getWeatherDetails(
    GetWeatherDetailsEvent event,
    Emitter<WeatherState> emit,
  ) async {
    emit(WeatherLoadingState());
    final result = await getWeatherDetailsUseCase(event.cityName);
    result.fold((l) {
      emit(WeatherErrorState(l));
    }, (r) {
      emit(WeatherLoadedState(r));
    });
  }
}
