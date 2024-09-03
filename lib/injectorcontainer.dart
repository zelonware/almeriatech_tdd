import 'package:get_it/get_it.dart';
import 'package:tddalmeriatech/data/repositories/weather_repositoryimpl.dart';
import 'package:tddalmeriatech/data/sources/remote_datasource.dart';
import 'package:tddalmeriatech/domain/repositories/weather_repository.dart';
import 'package:tddalmeriatech/domain/usecases/get_currentweather.dart';
import 'package:tddalmeriatech/presentation/bloc/weatherbloc.dart';
import 'package:http/http.dart' as http;

final locator = GetIt.instance;

void setupLocator() {
  // bloc
  locator.registerFactory(() => WeatherBloc(locator()));

  // use cases
  locator.registerLazySingleton(() => GetCurrentWeatherUseCase(locator()));

  // repository
  locator.registerLazySingleton<WeatherRepository>(
    () => WeatherRepositoryImpl(weatherRemoteDataSource: locator()),
  );

  // data sources
  locator.registerLazySingleton<WeatherDataSource>(
    () => RemoteDataSourceImpl(
      client: locator(),
    ),
  );

  // external
  locator.registerLazySingleton(() => http.Client());
}
