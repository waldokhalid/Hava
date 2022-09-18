import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hava/home/bloc/home_bloc.dart';
import 'package:hava/services/weatherService.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(
        RepositoryProvider.of<GetWeatherService>(context),
      )..add(LoadApiEvent()),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Hava"),
        ),
        body: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeLoadingState) {
              return Center(child: CircularProgressIndicator());
            } else if (state is HomeLoadedState) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(state.city.toString()),
                  ],
                ),
              );
            } else {
              print("Error");
              return Text("Error");
            }
            return Container(
              child: Center(
                child: Text("Nothing Here"),
              ),
            );
          },
        ),
      ),
    );
  }
}
