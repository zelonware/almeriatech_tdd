import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tddalmeriatech/core/constants.dart';
import 'package:tddalmeriatech/core/server_exception.dart';
import 'package:tddalmeriatech/data/models/weather_model.dart';

abstract class WeatherDataSource {
  Future<WeatherModel> getCurrentWeather(String city);
}

class RemoteDataSourceImpl extends WeatherDataSource {
  final http.Client client;
  RemoteDataSourceImpl({required this.client});

  @override
  Future<WeatherModel> getCurrentWeather(String city) async {
    final response =
        await client.get(Uri.parse(Urls.currentWeatherByName(city)));

    if (response.statusCode == 200) {
      return WeatherModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
