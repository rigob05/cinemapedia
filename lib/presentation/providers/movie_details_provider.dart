import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/movies_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Esta fue mi respuesta que estuvo cerca de ser correcta
// final movieInfoProvider = StateNotifierProvider<Movie>((ref) {
//   final fetchMovie = ref.watch(movieRepositoryProvider).getMovieById;
//   return MovieMapNotifier(fetchMovie);
// });

// Respuesta de Fernando DevTalles
final movieInfoProvider =
    StateNotifierProvider<MovieMapNotifier, Map<String, Movie>>((ref) {
      final movieRepository = ref.watch(movieRepositoryProvider);

      return MovieMapNotifier(getMovieId: movieRepository.getMovieById);
    });

typedef GetMovieCallback = Future<Movie> Function(String movieId);

class MovieMapNotifier extends StateNotifier<Map<String, Movie>> {
  final GetMovieCallback getMovieId;

  MovieMapNotifier({required this.getMovieId}) : super({});

  Future<void> loadMovie(String movieId) async {
    if (state[movieId] != null) return;
    print('Realizando peticion http');

    final movie = await getMovieId(movieId);

    state = {...state, movieId: movie};
  }
}

/*
 lo que mas o menos crearemos aqui es un mapa similar a esto 
  {
    id: movie();
    '14231': Movie(),
    '14233': Movie(),
    '14213': Movie(),
    '14256': Movie(),
    '1423123': Movie(),
  }
  Esta se debera ir cargando en el cache por si la vuelven a solicitar
  no se este creando una y otra vez la pedicion y volviendo a cargar 
  asi que se guardara en la memoria local
*/
