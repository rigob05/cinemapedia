import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/domain/repository/movie_repository.dart';
import 'package:cinemapedia/domain/sources/movie_src.dart';

class MovieRespositoryImpl extends MovieRepository {
  final MovieSrc datasource;
  MovieRespositoryImpl(this.datasource);

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) {
    return datasource.getNowPlaying(page: page);
  }

  @override
  Future<List<Movie>> getPopular({int page = 1}) {
    return datasource.getPopular(page: page);
  }

  @override
  Future<List<Movie>> getTopRated({int page = 1}) {
    return datasource.getTopRated(page: page);
  }

  @override
  Future<List<Movie>> getUpcoming({int page = 1}) {
    return datasource.getUpcoming(page: page);
  }
}
