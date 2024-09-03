import 'package:dartz/dartz.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tddalmeriatech/core/failure.dart';
import 'package:tddalmeriatech/domain/entities/weather_entity.dart';
import 'package:tddalmeriatech/presentation/bloc/weatherbloc.dart';
import 'package:tddalmeriatech/presentation/bloc/weatherevents.dart';
import 'package:tddalmeriatech/presentation/bloc/weatherstate.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockGetCurrentWeatherUseCase mockUseCase;
  late WeatherBloc testBloc;

  setUp(() {
    mockUseCase = MockGetCurrentWeatherUseCase();
    testBloc = WeatherBloc(mockUseCase);
  });

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

  test('initial state should be empty', () {
    expect(testBloc.state, WeatherEmpty());
  });

  blocTest<WeatherBloc, WeatherState>(
      'should emit [WeatherLoading, WeatherLoaded] when data is ✅',
      build: () {
        when(mockUseCase.execute(city))
            .thenAnswer((_) async => const Right(entity));
        return testBloc;
      },
      act: (bloc) => bloc.add(const OnCityChanged(city)),
      wait: const Duration(milliseconds: 500),
      expect: () => [WeatherLoading(), const WeatherLoaded(entity)]);

  blocTest<WeatherBloc, WeatherState>(
      'should emit [WeatherLoading, WeatherLoadFailure] when get data is ❌',
      build: () {
        when(mockUseCase.execute(city)).thenAnswer(
            (_) async => const Left(ServerFailure('Server failure')));
        return testBloc;
      },
      act: (bloc) => bloc.add(const OnCityChanged(city)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
            WeatherLoading(),
            const WeatherLoadFailure('Server failure'),
          ]);
}
