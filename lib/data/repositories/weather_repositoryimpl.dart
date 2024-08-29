import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:tddalmeriatech/core/failure.dart';
import 'package:tddalmeriatech/core/server_exception.dart';
import 'package:tddalmeriatech/data/sources/remote_datasource.dart';
import 'package:tddalmeriatech/domain/entities/weather_entity.dart';
import 'package:tddalmeriatech/domain/repositories/weather_repository.dart';

class WeatherRepositoryImpl extends WeatherRepository {
  final WeatherDataSource weatherRemoteDataSource;
  WeatherRepositoryImpl({required this.weatherRemoteDataSource});

  @override
  Future<Either<Failure, WeatherEntity>> getCurrentWeather(String city) async {
    try {
      final result = await weatherRemoteDataSource.getCurrentWeather(city);
      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure('An error has occurred'));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }
}
