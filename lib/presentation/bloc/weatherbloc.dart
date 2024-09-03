import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tddalmeriatech/domain/usecases/get_currentweather.dart';
import 'package:tddalmeriatech/presentation/bloc/weatherevents.dart';
import 'package:tddalmeriatech/presentation/bloc/weatherstate.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final GetCurrentWeatherUseCase usecase;
  WeatherBloc(this.usecase) : super(WeatherEmpty()) {
    on<OnCityChanged>(
      (event, emit) async {
        emit(WeatherLoading());
        final result = await usecase.execute(event.city);
        result.fold(
          (failure) {
            emit(WeatherLoadFailure(failure.message));
          },
          (data) {
            emit(WeatherLoaded(data));
          },
        );
      },
      transformer: debounce(const Duration(milliseconds: 500)),
    );
  }
}

EventTransformer<T> debounce<T>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}
