import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:hava/services/openWeatherMapApi.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';

// To parse this JSON data, do
//
//     final getWeatherDetails = getWeatherDetailsFromJson(jsonString);

GetWeatherDetails getWeatherDetailsFromJson(String str) =>
    GetWeatherDetails.fromJson(json.decode(str));

String getWeatherDetailsToJson(GetWeatherDetails data) =>
    json.encode(data.toJson());

class GetWeatherDetails {
  GetWeatherDetails({
    required this.cod,
    required this.message,
    required this.cnt,
    required this.list,
    required this.city,
  });

  String cod;
  int message;
  int cnt;
  List<ListElement> list;
  String city;

  factory GetWeatherDetails.fromJson(Map<String, dynamic> json) =>
      GetWeatherDetails(
        cod: json["cod"],
        message: json["message"],
        cnt: json["cnt"],
        list: List<ListElement>.from(
            json["list"].map((x) => ListElement.fromJson(x))),
        city: City.fromJson(json["city"]).toString(),
      );

  Map<String, dynamic> toJson() => {
        "cod": cod,
        "message": message,
        "cnt": cnt,
        "list": List<dynamic>.from(list.map((x) => x.toJson())),
        "city": city.toString(),
      };
}

class City {
  City({
    required this.id,
    required this.name,
    required this.coord,
    required this.country,
    required this.population,
    required this.timezone,
    required this.sunrise,
    required this.sunset,
  });

  int id;
  String name;
  Coord coord;
  String country;
  int population;
  int timezone;
  int sunrise;
  int sunset;

  factory City.fromJson(Map<String, dynamic> json) => City(
        id: json["id"],
        name: json["name"],
        coord: Coord.fromJson(json["coord"]),
        country: json["country"],
        population: json["population"],
        timezone: json["timezone"],
        sunrise: json["sunrise"],
        sunset: json["sunset"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "coord": coord.toJson(),
        "country": country,
        "population": population,
        "timezone": timezone,
        "sunrise": sunrise,
        "sunset": sunset,
      };
}

class Coord {
  Coord({
    required this.lat,
    required this.lon,
  });

  double lat;
  double lon;

  factory Coord.fromJson(Map<String, dynamic> json) => Coord(
        lat: json["lat"].toDouble(),
        lon: json["lon"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "lat": lat,
        "lon": lon,
      };
}

class ListElement {
  ListElement({
    required this.dt,
    required this.main,
    required this.weather,
    required this.sys,
    required this.dtTxt,
  });

  int dt;
  Main main;
  List<Weather> weather;
  Sys sys;
  DateTime dtTxt;

  factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
        dt: json["dt"],
        main: Main.fromJson(json["main"]),
        weather:
            List<Weather>.from(json["weather"].map((x) => Weather.fromJson(x))),
        sys: Sys.fromJson(json["sys"]),
        dtTxt: DateTime.parse(json["dt_txt"]),
      );

  Map<String, dynamic> toJson() => {
        "dt": dt,
        "main": main.toJson(),
        "weather": List<dynamic>.from(weather.map((x) => x.toJson())),
        "sys": sys.toJson(),
        "dt_txt": dtTxt.toIso8601String(),
      };
}

class Main {
  Main({
    required this.temp,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
  });

  double temp;
  double feelsLike;
  double tempMin;
  double tempMax;

  factory Main.fromJson(Map<String, dynamic> json) => Main(
        temp: json["temp"].toDouble(),
        feelsLike: json["feels_like"].toDouble(),
        tempMin: json["temp_min"].toDouble(),
        tempMax: json["temp_max"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "temp": temp,
        "feels_like": feelsLike,
        "temp_min": tempMin,
        "temp_max": tempMax,
      };
}

class Sys {
  Sys({
    required this.pod,
  });

  String pod;

  factory Sys.fromJson(Map<String, dynamic> json) => Sys(
        pod: json["pod"],
      );

  Map<String, dynamic> toJson() => {
        "pod": pod,
      };
}

class Weather {
  Weather({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
  });

  int id;
  String main;
  String description;
  String icon;

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
        id: json["id"],
        main: json["main"],
        description: json["description"],
        icon: json["icon"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "main": main,
        "description": description,
        "icon": icon,
      };
}

class GetWeatherService {
  late LocationPermission checkPermission;
  late LocationPermission requestPermission;

  List coordinatesList = [];
  late dynamic latitude;
  late dynamic longitude;

  //CHECK AND GET LOCATION PERMISSION
  Future checkAndGetLocationPermissions() async {
    // Check if gps is enabled
    bool servicestatus = await Geolocator.isLocationServiceEnabled();
    await Geolocator.requestPermission();
    await Geolocator.checkPermission();

   

    if (servicestatus) {
      if (kDebugMode) {
        print("GPS service is enabled");
      }
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      latitude = position.latitude;
      print(latitude);
      longitude = position.longitude;
      print(longitude);
      coordinatesList.add(latitude);
      coordinatesList.add(longitude);

      if (kDebugMode) {
        print(coordinatesList);
      }
      return coordinatesList;
    } else {
      if (kDebugMode) {
        print("GPS service is disabled.");
      }

      // // Check for and request location permission
      // permission = await Geolocator.checkPermission();

      // if (permission == LocationPermission.denied) {
      //   permission = await Geolocator.requestPermission();
      //   if (permission == LocationPermission.denied) {
      //     if (kDebugMode) {
      //       print('Location permissions are denied');
      //     }
      //   } else if (permission == LocationPermission.deniedForever) {
      //     if (kDebugMode) {
      //       print("Location permissions are permanently denied");
      //     }
      //   } else {
      //     if (kDebugMode) {
      //       print("GPS Location service is granted");
      //     }
      //   }
      // } else {
      //   if (kDebugMode) {
      //     print("GPS Location permission granted.");
      //   }
      // }
    }

    // final response = await http.get(Uri.parse(
    //     "api.openweathermap.org/data/2.5/forecast?lat=${$position.lattude}&lon=$longitude&appid=$openWeatherMapApiKey"));
    // final weatherDetails = getWeatherDetailsFromJson(response.body);
    // return weatherDetails;
  }

  Future<GetWeatherDetails> getWeather() async {
    dynamic latLong = await checkAndGetLocationPermissions() as List;

    // print(latLong.runtimeType);
    print("latLong, $latLong");
    double latitude = latLong[0];
    double longitude = latLong[1];

    final response = await http.get(Uri.parse(
        "http://api.openweathermap.org/data/2.5/forecast?lat=$latitude&lon=$longitude&appid=$openWeatherMapApiKey"));
    final weatherDetails = getWeatherDetailsFromJson(response.body.toString());

    return weatherDetails;
  }
}
