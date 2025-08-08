import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static String THE_MOVIE_DB_KEY = dotenv.env['THE_MOVIE_DB_KEY'] ?? 'Aqui deberia ir la API KEY';
}