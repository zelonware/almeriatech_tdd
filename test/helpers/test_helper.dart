import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:tddalmeriatech/domain/repositories/weather_repository.dart';

@GenerateMocks(
  [WeatherRepository],
  customMocks: [MockSpec<http.Client>(as: #MockHttpClient)],
)
void main() {}
