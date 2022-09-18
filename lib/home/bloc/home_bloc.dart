import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hava/services/weatherService.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetWeatherService _getWeatherService;

  HomeBloc(this._getWeatherService) : super(HomeLoadingState()) {
    on<LoadApiEvent>((event, emit) async {
      // TODO: implement event handler
      emit(HomeLoadingState());
      final activity = await _getWeatherService.getWeather();
      print(activity.city);
      emit(HomeLoadedState(activity.city));
    });
  }
}
