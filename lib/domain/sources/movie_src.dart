import 'package:cinemapedia/domain/entities/movie.dart';

abstract class MovieSrc {
  Future<List<Movie>> getNowPlaying({int page = 1});
}
