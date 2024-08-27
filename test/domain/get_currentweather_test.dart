import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tddalmeriatech/domain/entities/weather_entity.dart';
import 'package:tddalmeriatech/domain/usecases/get_currentweather.dart';

import '../helpers/test_helper.mocks.dart';

void main() {
  late GetCurrentWeatherUseCase useCase;
  late MockWeatherRepository mockRepo;

  setUp(() {
    mockRepo = MockWeatherRepository();
    useCase = GetCurrentWeatherUseCase(mockRepo);
  });

  const testWeather = WeatherEntity(
    cityName: 'Almería',
    main: 'Clouds',
    description: 'few clouds',
    iconCode: '02d',
    temperature: 302.28,
    pressure: 1009,
    humidity: 70,
  );

  const testCity = 'Almería';

  test('should get current weather from repository', () async {
    // arrange
    when(mockRepo.getCurrentWeather(testCity))
        .thenAnswer((_) async => const Right(testWeather));

    // act
    final result = await useCase.execute(testCity);

    // assert
    expect(result, const Right(testWeather));
  });
}
