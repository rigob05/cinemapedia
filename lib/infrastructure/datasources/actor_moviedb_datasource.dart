import 'package:cinemapedia/config/constant/environment.dart';
import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/domain/sources/actors_datasources.dart';
import 'package:cinemapedia/infrastructure/mappers/actors_mapper.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/credits_response.dart';
import 'package:dio/dio.dart';

List<Actor> _JsonToActors(Map<String, dynamic> json) {
  final actorMovieDBResponse = CreditsResponse.fromJson(json);
  final List<Actor> actors = actorMovieDBResponse.cast
      .where((actors) => actors.profilePath != 'no-profile')
      .map((actors) => ActorsMapper.castEntity(actors))
      .toList();
  return actors;
}

class ActorsMovieDBDataSource extends ActorsDatasources {
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
  Future<List<Actor>> getActorsByMovie(String movieId) async {
    final response = await dio.get(
      '/movie/$movieId/credits',
      queryParameters: {'movieId': movieId},
    );
    return _JsonToActors(response.data);
  }
}
