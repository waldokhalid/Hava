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
        appBar: AppBar(
          backgroundColor: Colors.transparent.withOpacity(0.0),
          centerTitle: true,
          elevation: 0,
          title: Text(
            "Hava",
            style: GoogleFonts.lexendTera(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
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
                              height: (MediaQuery.of(context).size.height) / 4,
                              width: (MediaQuery.of(context).size.width) / 1.1,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white.withOpacity(0.7),
                              ),
                              // height: (MediaQuery.of(context).size.height) / 2,
                              // width: (MediaQuery.of(context).size.width),
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
                                          state.timeZone,
                                          style: GoogleFonts.lexendTera(
                                            fontSize: 24,
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
                                          fontSize: 20,
                                          color: Colors.black,
                                        ),
                                      ),
                                      Image(
                                        image: NetworkImage(
                                            "http://openweathermap.org/img/w/${state.icon}.png"),
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
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                          ),
                          height: (MediaQuery.of(context).size.height) / 5,
                          width: (MediaQuery.of(context).size.width) / 1.1,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.black.withOpacity(0.7),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    weekDays[state.dayOneDate - 1],
                                    style: GoogleFonts.lexendPeta(
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    state.dayOneTemp.toString() + "℃",
                                    style: GoogleFonts.lexendPeta(
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
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    weekDays[state.dayTwoDate - 1],
                                    style: GoogleFonts.lexendPeta(
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    state.dayTwoTemp.toString() + "℃",
                                    style: GoogleFonts.lexendPeta(
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
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    weekDays[state.dayThreeDate - 1],
                                    style: GoogleFonts.lexendPeta(
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    state.dayThreeTemp.toString() + "℃",
                                    style: GoogleFonts.lexendPeta(
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
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    weekDays[state.dayFourDate - 1],
                                    style: GoogleFonts.lexendPeta(
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    state.dayFourTemp.toString() + "℃",
                                    style: GoogleFonts.lexendPeta(
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
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    weekDays[state.dayFiveDate - 1],
                                    style: GoogleFonts.lexendPeta(
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    state.dayFiveTemp.toString() + "℃",
                                    style: GoogleFonts.lexendPeta(
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
                        // Center(
                        //   child: Padding(
                        //     padding: const EdgeInsets.all(15.0),
                        //     child: Container(
                        //       height: MediaQuery.of(context).size.height / 3.5,
                        //       width: MediaQuery.of(context).size.width / 1.1,
                        //       decoration: const BoxDecoration(
                        //           // color: Colors.white.withOpacity(0.5),
                        //           ),
                        //       child: Row(
                        //         mainAxisAlignment:
                        //             MainAxisAlignment.spaceEvenly,
                        //         children: [
                        //           Column(
                        //             mainAxisAlignment:
                        //                 MainAxisAlignment.spaceEvenly,
                        //             children: [
                        //               const Icon(
                        //                 WeatherIcons.thermometer,
                        //                 color: Colors.redAccent,
                        //                 size: 45,
                        //               ),
                        //               Text(
                        //                 "state.highTemp.toString()" + "℃",
                        //                 style: GoogleFonts.lexendPeta(
                        //                   fontSize: 14,
                        //                   color: Colors.white,
                        //                 ),
                        //               ),
                        //             ],
                        //           ),
                        //           Column(
                        //             mainAxisAlignment:
                        //                 MainAxisAlignment.spaceEvenly,
                        //             children: [
                        //               const Icon(
                        //                 WeatherIcons.snowflake_cold,
                        //                 color: Colors.purple,
                        //                 size: 45,
                        //               ),
                        //               Text(
                        //                 "state.feelTemp.toString()" + "℃",
                        //                 style: GoogleFonts.lexendPeta(
                        //                   fontSize: 14,
                        //                   color: Colors.white,
                        //                 ),
                        //               ),
                        //             ],
                        //           ),
                        //           Column(
                        //             mainAxisAlignment:
                        //                 MainAxisAlignment.spaceEvenly,
                        //             children: [
                        //               const Icon(
                        //                 WeatherIcons.thermometer,
                        //                 color: Colors.greenAccent,
                        //                 size: 45,
                        //               ),
                        //               Text(
                        //                 "state.lowTemp.toString()" + "℃",
                        //                 style: GoogleFonts.lexendPeta(
                        //                   fontSize: 14,
                        //                   color: Colors.white,
                        //                 ),
                        //               ),
                        //             ],
                        //           ),

                        //           // Padding(
                        //           //   padding: const EdgeInsets.all(25.0),
                        //           //   child: Row(
                        //           //     mainAxisAlignment:
                        //           //         MainAxisAlignment.spaceEvenly,
                        //           //     children: [
                        //           //       Text(state.highTemp.toString()),
                        //           //       Text(state.lowTemp.toString()),
                        //           //     ],
                        //           //   ),
                        //           // ),
                        //           // Row(
                        //           //   children: [],
                        //           // ),
                        //         ],
                        //       ),
                        //     ),
                        //   ),
                        // ),
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

mixin $ {}
