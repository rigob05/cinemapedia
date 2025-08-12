import 'package:cinemapedia/infrastructure/mappers/movie_mapper.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/moviedb_response.dart';
import 'package:dio/dio.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/domain/sources/movie_src.dart';
import 'package:cinemapedia/config/constant/environment.dart';

List<Movie> _JsonToMovies(Map<String, dynamic> json) {
  final movieDBResponse = MovieDbResponse.fromJson(json);
  final List<Movie> movies =
      movieDBResponse.results
          .where((moviedb) => moviedb.posterPath != 'no-poster')
          .map((moviedb) => MovieMapper.movieDBToEntity(moviedb))
          .toList()
        ..sort((a, b) => b.releaseDate.compareTo(a.releaseDate));

  return movies;
}

class MoviedbDatasource extends MovieSrc {
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
      queryParameters: {
        'api_key': Environment.THE_MOVIE_DB_KEY,
        'language': 'es-MX',
      },
    ),
  );

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    final response = await dio.get(
      '/movie/now_playing',
      queryParameters: {'page': page},
    );
    return _JsonToMovies(response.data);
  }

  @override
  Future<List<Movie>> getPopular({int page = 1}) async {
    final response = await dio.get(
      '/movie/popular',
      queryParameters: {'page': page},
    );
    return _JsonToMovies(response.data);
  }

  @override
  Future<List<Movie>> getTopRated({int page = 1}) async {
    final response = await dio.get(
      '/movie/top_rated',
      queryParameters: {'page': page},
    );
    return _JsonToMovies(response.data);
  }

  @override
  Future<List<Movie>> getUpcoming({int page = 1}) async {
    final response = await dio.get('/movie/upcoming');
    return _JsonToMovies(response.data);
  }
}
