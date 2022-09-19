part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();
}

class HomeLoadingState extends HomeState {
  @override
  List<Object> get props => [];
}

class HomeLoadedState extends HomeState {
  final dynamic timeZone;
  final dynamic temp;
  final dynamic feelsLike;
  final dynamic icon;

  final dynamic dayOneTemp;
  final dynamic dayOneIcon;
  final dynamic dayTwoTemp;
  final dynamic dayTwoIcon;
  final dynamic dayThreeTemp;
  final dynamic dayThreeIcon;
  final dynamic dayFourTemp;
  final dynamic dayFourIcon;
  final dynamic dayFiveTemp;
  final dynamic dayFiveIcon;

  final dynamic dayOneDate;
  final dynamic dayTwoDate;
  final dynamic dayThreeDate;
  final dynamic dayFourDate;
  final dynamic dayFiveDate;

  final dynamic highTemp;
  final dynamic lowTemp;
  final dynamic humidity;

  const HomeLoadedState(
    this.timeZone,
    this.temp,
    this.feelsLike,
    this.icon,
    this.dayOneTemp,
    this.dayOneIcon,
    this.dayTwoTemp,
    this.dayTwoIcon,
    this.dayThreeTemp,
    this.dayThreeIcon,
    this.dayFourTemp,
    this.dayFourIcon,
    this.dayFiveTemp,
    this.dayFiveIcon,
    this.dayOneDate,
    this.dayTwoDate,
    this.dayThreeDate,
    this.dayFourDate,
    this.dayFiveDate,
    this.highTemp,
    this.lowTemp,
    this.humidity,
  );

  @override
  List<Object?> get props => [
        timeZone,
        temp,
        icon,
        dayOneTemp,
        dayOneIcon,
        dayTwoTemp,
        dayTwoIcon,
        dayThreeTemp,
        dayThreeIcon,
        dayFourTemp,
        dayFourIcon,
        dayFiveTemp,
        dayFiveIcon,
        dayOneDate,
        dayTwoDate,
        dayThreeDate,
        dayFourDate,
        dayFiveDate
      ];
}
