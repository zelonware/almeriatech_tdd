import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tddalmeriatech/data/models/weather_model.dart';
import 'package:tddalmeriatech/domain/entities/weather_entity.dart';

import '../../helpers/json_reader.dart';

void main() {
  const testModel = WeatherModel(
    cityName: 'New York',
    main: 'Clear',
    description: 'clear sky',
    iconCode: '01n',
    temperature: 292.87,
    pressure: 1012,
    humidity: 70,
  );

  test('should be a subclass of entity', () async {
    //assert
    expect(testModel, isA<WeatherEntity>());
  });

  test('should return a valid model from json data', () async {
    //arrange
    final Map<String, dynamic> jsonData = json.decode(
      readJson('helpers/dummydata/weather_response.json'),
    );

    //act
    final result = WeatherModel.fromJson(jsonData);

    //assert
    expect(result, equals(testModel));
  });

  test(
    'should return a json containing valid data',
    () async {
      // act
      final result = testModel.toJson();

      // assert
      final expectedJson = {
        'weather': [
          {
            'main': 'Clear',
            'description': 'clear sky',
            'icon': '01n',
          }
        ],
        'main': {
          'temp': 292.87,
          'pressure': 1012,
          'humidity': 70,
        },
        'name': 'New York',
      };

      expect(result, equals(expectedJson));
    },
  );
}
