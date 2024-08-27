import 'package:dartz/dartz.dart';
import 'package:tddalmeriatech/core/failure.dart';
import 'package:tddalmeriatech/domain/entities/weather_entity.dart';
import 'package:tddalmeriatech/domain/repositories/weather_repository.dart';

class GetCurrentWeatherUseCase {
  final WeatherRepository repository;

  GetCurrentWeatherUseCase(this.repository);

  Future<Either<Failure, WeatherEntity>> execute(String city) {
    return repository.getCurrentWeather(city);
  }
}
