import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/domain/repository/local_storage_repository.dart';
import 'package:cinemapedia/domain/sources/local_storage_datasources.dart';

class LocalStorageRepositoryImpl extends LocalStorageRepository {
  final LocalStorageDatasources datasources;

  LocalStorageRepositoryImpl({required this.datasources});

  @override
  Future<bool> isMovieFavorite(int movieId) {
    return datasources.isMovieFavorite(movieId);
  }

  @override
  Future<List<Movie>> loadMovies({int limit = 10, offset = 0}) {
    return datasources.loadMovies(limit: limit, offset: offset);
  }

  @override
  Future<void> toggleFavorite(Movie movie) {
    return datasources.toggleFavorite(movie);
  }
}
