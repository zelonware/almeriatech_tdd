import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:tddalmeriatech/data/sources/remote_datasource.dart';
import 'package:tddalmeriatech/domain/repositories/weather_repository.dart';
import 'package:tddalmeriatech/domain/usecases/get_currentweather.dart';

@GenerateMocks(
  [WeatherRepository, WeatherDataSource, GetCurrentWeatherUseCase],
  customMocks: [MockSpec<http.Client>(as: #MockHttpClient)],
)
void main() {}
