import 'package:dartz/dartz.dart';
import 'package:tddalmeriatech/core/failure.dart';
import 'package:tddalmeriatech/domain/entities/weather.dart';

abstract class WeatherRepository {
  Future<Either<Failure, WeatherEntity>> getCurrentWeather(String city);
}
