import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/presentation/providers/actors/actor_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Esta fue mi respuesta que estuvo cerca de ser correcta
// final movieInfoProvider = StateNotifierProvider<Movie>((ref) {
//   final fetchMovie = ref.watch(movieRepositoryProvider).getMovieById;
//   return ActorByMovieNotifier(fetchMovie);
// });

// Respuesta de Fernando DevTalles
final actorsByMovieProvider =
    StateNotifierProvider<ActorByMovieNotifier, Map<String, List<Actor>>>((
      ref,
    ) {
      final actorRepository = ref.watch(actorRepositoryProvider);

      return ActorByMovieNotifier(getActors: actorRepository.getActorsByMovie);
    });

typedef GetActorsCallback = Future<List<Actor>> Function(String movieId);

class ActorByMovieNotifier extends StateNotifier<Map<String, List<Actor>>> {
  final GetActorsCallback getActors;

  ActorByMovieNotifier({required this.getActors}) : super({});

  Future<void> loadActor(String movieId) async {
    if (state[movieId] != null) return;

    final actor = await getActors(movieId);

    state = {...state, movieId: actor};
  }
}

/*
 lo que mas o menos crearemos aqui es un mapa similar a esto 
  {
    id: <Actor>[];
    '14231': <Actor>[],
    '14233': <Actor>[],
    '14213': <Actor>[],
    '14256': <Actor>[],
    '1423123': <Actor>[],
  }
  Esta se debera ir cargando en el cache por si la vuelven a solicitar
  no se este creando una y otra vez la pedicion y volviendo a cargar 
  asi que se guardara en la memoria local
*/
