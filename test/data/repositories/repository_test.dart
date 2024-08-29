import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tddalmeriatech/core/failure.dart';
import 'package:tddalmeriatech/core/server_exception.dart';
import 'package:tddalmeriatech/data/models/weather_model.dart';
import 'package:tddalmeriatech/data/repositories/weather_repositoryimpl.dart';
import 'package:tddalmeriatech/domain/entities/weather_entity.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockWeatherDataSource mockDataSource;
  late WeatherRepositoryImpl mockRepo;

  setUp(() {
    mockDataSource = MockWeatherDataSource();
    mockRepo = WeatherRepositoryImpl(
      weatherRemoteDataSource: mockDataSource,
    );
  });

  const model = WeatherModel(
    cityName: 'New York',
    main: 'Clouds',
    description: 'few clouds',
    iconCode: '02d',
    temperature: 302.28,
    pressure: 1009,
    humidity: 70,
  );

  const entity = WeatherEntity(
    cityName: 'New York',
    main: 'Clouds',
    description: 'few clouds',
    iconCode: '02d',
    temperature: 302.28,
    pressure: 1009,
    humidity: 70,
  );

  const city = 'New York';

  group('get current weather', () {
    test(
      'should return current weather when call to data source is ✅',
      () async {
        // arrange
        when(mockDataSource.getCurrentWeather(city))
            .thenAnswer((_) async => model);

        // act
        final result = await mockRepo.getCurrentWeather(city);

        // assert
        expect(result, equals(const Right(entity)));
      },
    );

    test(
      'should return server failure when call to data source is ❌',
      () async {
        // arrange
        when(mockDataSource.getCurrentWeather(city))
            .thenThrow(ServerException());

        // act
        final result = await mockRepo.getCurrentWeather(city);

        // assert
        expect(
            result, equals(const Left(ServerFailure('An error has occurred'))));
      },
    );
  });
}
