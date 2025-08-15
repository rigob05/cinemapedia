import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/domain/repository/actors_repository.dart';
import 'package:cinemapedia/domain/sources/actors_datasources.dart';

class ActorRepositoryImpl extends ActorsRepository {
  final ActorsDatasources datasources;

  ActorRepositoryImpl({required this.datasources});

  @override
  Future<List<Actor>> getActorsByMovie(String movieId) async {
    return datasources.getActorsByMovie(movieId);
  }
}
