import 'package:equatable/equatable.dart';
import 'package:tddalmeriatech/domain/entities/weather_entity.dart';

abstract class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object?> get props => [];
}

class WeatherEmpty extends WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherLoaded extends WeatherState {
  final WeatherEntity result;

  const WeatherLoaded(this.result);

  @override
  List<Object?> get props => [result];
}

class WeatherLoadFailure extends WeatherState {
  final String msg;

  const WeatherLoadFailure(this.msg);

  @override
  List<Object?> get props => [msg];
}
