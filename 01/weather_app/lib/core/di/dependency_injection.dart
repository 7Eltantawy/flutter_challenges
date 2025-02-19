import 'package:get_it/get_it.dart';
import 'package:weather_app/features/home/data/data_source/weather_remote_data_source.dart';
import 'package:weather_app/features/home/data/repository/weather_repo.dart';
import 'package:weather_app/features/home/domain/repository/base_weather_repo.dart';
import 'package:weather_app/features/home/domain/use_cases/get_weather_details.dart';
import 'package:weather_app/features/home/presentation/controller/bloc/weather_bloc.dart';

final sl = GetIt.instance;

Future<void> initSL() async {
  ///Init DataSources
  sl.registerLazySingleton<BaseWeatherRemoteDataSource>(
      () => WeatherRemoteDataSource());

  ///Init Repos
  sl.registerLazySingleton<BaseWeatherRepo>(() => WeatherRepo(sl()));

  ///Init usecases
  sl.registerLazySingleton(() => GetWeatherDetailsUseCase(sl()));

  ///Init blocs and cubits
  sl.registerFactory(() => WeatherBloc(sl()));
}
