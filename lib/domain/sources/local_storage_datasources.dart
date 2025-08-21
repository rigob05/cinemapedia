import 'package:cinemapedia/domain/entities/movie.dart';

abstract class LocalStorageDatasources {
  Future<void> toggleFavorite(Movie movie);

  Future<bool> isMovieFavorite(int movideId);

  Future<List<Movie>> loadMovies({int limit = 10, offset = 0});
}
