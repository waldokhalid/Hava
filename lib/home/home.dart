import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hava/home/bloc/home_bloc.dart';
import 'package:hava/services/weatherService.dart';
import 'package:weather_icons/weather_icons.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List weekDays = ["Mon", "Tue", "Wed", "Thur", "Fri", "Sat", "Sun"];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(
        RepositoryProvider.of<GetWeatherService>(context),
      )..add(LoadApiEvent()),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                image: AssetImage("assets/images/Sea-sunny.png"),
                fit: BoxFit.cover,
              )),
            ),
            BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                if (state is HomeLoadingState) {
                  return Center(
                      child: CircularProgressIndicator(
                    color: Colors.white.withOpacity(0.5),
                  ));
                } else if (state is HomeLoadedState) {
                  return Center(
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: (MediaQuery.of(context).size.height) / 2.28,
                          child: Center(
                            child: Container(
                              height: (MediaQuery.of(context).size.height) / 3,
                              width: (MediaQuery.of(context).size.width) / 1.1,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white.withOpacity(0.7),
                              ),
                              // height: (MediaQuery.of(context).size.he
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 15),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          userLoc,
                                          style: GoogleFonts.lexendTera(
                                            fontSize: 12,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        state.temp.toString() + "℃",
                                        style: GoogleFonts.lexendTera(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image(
                                            image: NetworkImage(
                                              "http://openweathermap.org/img/w/${state.icon}.png",
                                            ),
                                          ),
                                          Text(
                                            state.weatherDesc.toString(),
                                            style: GoogleFonts.lexendTera(
                                              fontSize: 10,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        "Feels Like: " +
                                            state.feelsLike.toString() +
                                            "℃",
                                        style: GoogleFonts.lexendTera(
                                          fontSize: 12,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Icon(
                                              WeatherIcons.thermometer,
                                              color: Colors.red,
                                            ),
                                          ),
                                          Text(
                                            state.highTemp.toString() + "℃",
                                            style: GoogleFonts.lexendTera(
                                              fontSize: 12,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Icon(
                                              WeatherIcons.thermometer,
                                              color: Colors.blueAccent,
                                            ),
                                          ),
                                          Text(
                                            state.lowTemp.toString() + "℃",
                                            style: GoogleFonts.lexendTera(
                                              fontSize: 12,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Icon(
                                              WeatherIcons.humidity,
                                              color: Colors.greenAccent,
                                            ),
                                          ),
                                          Text(
                                            state.humidity.toString(),
                                            style: GoogleFonts.lexendTera(
                                              fontSize: 12,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 1.8,
                          child: Center(
                            child: Container(
                              height: (MediaQuery.of(context).size.height) / 2,
                              width: (MediaQuery.of(context).size.width) / 1.1,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.black.withOpacity(0.7),
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        weekDays[state.dayOneDate - 1],
                                        style: GoogleFonts.lexendTera(
                                          fontSize: 12,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text(
                                        state.dayOneTemp.toString() + "℃",
                                        style: GoogleFonts.lexendTera(
                                          fontSize: 12,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Image(
                                        image: NetworkImage(
                                            "http://openweathermap.org/img/w/${state.dayOneIcon}.png"),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        weekDays[state.dayTwoDate - 1],
                                        style: GoogleFonts.lexendTera(
                                          fontSize: 12,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text(
                                        state.dayTwoTemp.toString() + "℃",
                                        style: GoogleFonts.lexendTera(
                                          fontSize: 12,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Image(
                                        image: NetworkImage(
                                            "http://openweathermap.org/img/w/${state.dayTwoIcon}.png"),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        weekDays[state.dayThreeDate - 1],
                                        style: GoogleFonts.lexendTera(
                                          fontSize: 12,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text(
                                        state.dayThreeTemp.toString() + "℃",
                                        style: GoogleFonts.lexendTera(
                                          fontSize: 12,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Image(
                                        image: NetworkImage(
                                            "http://openweathermap.org/img/w/${state.dayThreeIcon}.png"),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        weekDays[state.dayFourDate - 1],
                                        style: GoogleFonts.lexendTera(
                                          fontSize: 12,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text(
                                        state.dayFourTemp.toString() + "℃",
                                        style: GoogleFonts.lexendTera(
                                          fontSize: 12,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Image(
                                        image: NetworkImage(
                                            "http://openweathermap.org/img/w/${state.dayFourIcon}.png"),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        weekDays[state.dayFiveDate - 1],
                                        style: GoogleFonts.lexendTera(
                                          fontSize: 12,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text(
                                        state.dayFiveTemp.toString() + "℃",
                                        style: GoogleFonts.lexendTera(
                                          fontSize: 12,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Image(
                                        image: NetworkImage(
                                            "http://openweathermap.org/img/w/${state.dayFiveIcon}.png"),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return const Text("Error");
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
