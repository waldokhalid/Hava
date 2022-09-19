import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

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

      var sunRise =
          DateTime.fromMillisecondsSinceEpoch(activity.current.sunrise * 1000);
      var sunSet =
          DateTime.fromMillisecondsSinceEpoch(activity.current.sunset * 1000);

      var dayOneWeekday =
          DateTime.fromMillisecondsSinceEpoch(activity.daily[0].dt * 1000)
              .weekday;
      var dayTwoWeekday =
          DateTime.fromMillisecondsSinceEpoch(activity.daily[1].dt * 1000)
              .weekday;
      var dayThreeWeekday =
          DateTime.fromMillisecondsSinceEpoch(activity.daily[2].dt * 1000)
              .weekday;
      var dayFourWeekday =
          DateTime.fromMillisecondsSinceEpoch(activity.daily[3].dt * 1000)
              .weekday;
      var dayFiveWeekday =
          DateTime.fromMillisecondsSinceEpoch(activity.daily[5].dt * 1000)
              .weekday;

      emit(HomeLoadedState(
        activity.timezone,
        activity.current.temp.toInt(),
        activity.current.feelsLike.toInt(),
        activity.current.weather[0].icon,
        activity.daily[0].temp.day.toInt(),
        activity.daily[0].weather[0].icon,
        activity.daily[1].temp.day.toInt(),
        activity.daily[1].weather[0].icon,
        activity.daily[2].temp.day.toInt(),
        activity.daily[2].weather[0].icon,
        activity.daily[3].temp.day.toInt(),
        activity.daily[3].weather[0].icon,
        activity.daily[4].temp.day.toInt(),
        activity.daily[4].weather[0].icon,
        dayOneWeekday,
        dayTwoWeekday,
        dayThreeWeekday,
        dayFourWeekday,
        dayFiveWeekday,
      ));

      // emit(HomeLoadedState(
      //   activity.city.name.toString(),
      //   acti
      //   activity.list[0].main.temp.toInt(),
      //   activity.list[0].weather[0].main.toString(),
      //   {sunRise.hour: sunRise.minute},
      //   {sunSet.hour: sunSet.minute},
      //   activity.list[1].main.temp.toInt(),
      //   activity.list[1].main.temp,
      //   activity.list[2].main.temp.toInt(),
      //   activity.list[3].main.temp.toInt(),
      //   activity.list[4].main.temp.toInt(),
      //   activity.list[5].main.temp.toInt(),
      //   // dayOneDate.toInt(),
      //   // dayTwoDate.toInt(),
      //   // dayThreeDate.toInt(),
      //   // dayFourDate..toInt(),
      //   // dayFiveDate.toInt(),
      //   // activity.list[1].dt,
      //   // activity.list[2].dt,
      //   // activity.list[3].dt,
      //   // activity.list[4].dt,
      //   // activity.list[5].dt,
      //   activity.list[0].main.tempMax.toInt(),
      //   activity.list[0].main.tempMin.toInt(),
      //   activity.list[0].main.feelsLike.toInt(),
      //   activity.list[0].weather[0].icon,
      //   activity.list[1].weather[0].icon,
      //   activity.list[2].weather[0].icon,
      //   activity.list[3].weather[0].icon,
      //   activity.list[4].weather[0].icon,
      //   activity.list[5].weather[0].icon,
      // ));
    });
  }
}
