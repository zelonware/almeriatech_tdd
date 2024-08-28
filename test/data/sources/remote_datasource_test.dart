import 'package:http/http.dart' as http;
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tddalmeriatech/core/constants.dart';
import 'package:tddalmeriatech/core/server_exception.dart';
import 'package:tddalmeriatech/data/models/weather_model.dart';
import 'package:tddalmeriatech/data/sources/remote_datasource.dart';

import '../../helpers/json_reader.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockHttpClient mockClient;
  late RemoteDataSourceImpl impl;

  setUp(() {
    mockClient = MockHttpClient();
    impl = RemoteDataSourceImpl(client: mockClient);
  });

  const testCity = 'New York';

  group('get current weather', () {
    test('should return model when response code = 200', () async {
      //arrange
      when(mockClient.get(Uri.parse(Urls.currentWeatherByName(testCity))))
          .thenAnswer((_) async => http.Response(
              readJson('helpers/dummydata/weather_response.json'), 200));

      //act
      final result = await impl.getCurrentWeather(testCity);

      //assert
      expect(result, isA<WeatherModel>());
    });

    test(
      'should throw exception when response code = 404',
      () async {
        //arrange
        when(
          mockClient.get(Uri.parse(Urls.currentWeatherByName(testCity))),
        ).thenAnswer((_) async => http.Response('Not found', 404));

        //act
        final result = impl.getCurrentWeather(testCity);

        //assert
        expect(result, throwsA(isA<ServerException>()));
      },
    );
  });
}
