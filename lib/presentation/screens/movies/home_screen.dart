import 'package:cinemapedia/config/constant/environment.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {

  static final name = 'home-screen';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Aqui esta la API KEY ${Environment.THE_MOVIE_DB_KEY}"),
      ),
    );
  }
}