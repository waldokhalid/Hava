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

      var dayOneWeekday =
          DateTime.fromMillisecondsSinceEpoch(activity.daily[1].dt * 1000)
              .weekday;
      var dayTwoWeekday =
          DateTime.fromMillisecondsSinceEpoch(activity.daily[2].dt * 1000)
              .weekday;
      var dayThreeWeekday =
          DateTime.fromMillisecondsSinceEpoch(activity.daily[3].dt * 1000)
              .weekday;
      var dayFourWeekday =
          DateTime.fromMillisecondsSinceEpoch(activity.daily[4].dt * 1000)
              .weekday;
      var dayFiveWeekday =
          DateTime.fromMillisecondsSinceEpoch(activity.daily[5].dt * 1000)
              .weekday;

      emit(HomeLoadedState(
        activity.timezone,
        activity.current.temp.toInt(),
        activity.current.feelsLike.toInt(),
        activity.current.weather[0].icon,
        activity.current.weather[0].description,
        activity.daily[1].temp.day.toInt(),
        activity.daily[1].weather[0].icon,
        activity.daily[2].temp.day.toInt(),
        activity.daily[2].weather[0].icon,
        activity.daily[3].temp.day.toInt(),
        activity.daily[3].weather[0].icon,
        activity.daily[4].temp.day.toInt(),
        activity.daily[4].weather[0].icon,
        activity.daily[5].temp.day.toInt(),
        activity.daily[5].weather[0].icon,
        dayOneWeekday,
        dayTwoWeekday,
        dayThreeWeekday,
        dayFourWeekday,
        dayFiveWeekday,
        activity.daily[0].temp.max.toInt(),
        activity.daily[0].temp.min.toInt(),
        activity.current.humidity,
      ));
    });
  }
}
