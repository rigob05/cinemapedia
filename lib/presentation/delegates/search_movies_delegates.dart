import 'dart:async';
import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter/material.dart';

typedef SearchMovieCallBack = Future<List<Movie>> Function(String query);

class SearchMoviesDelegates extends SearchDelegate<Movie?> {
  final SearchMovieCallBack searchMovie;
  List<Movie> initialMovies;
  StreamController<List<Movie>> debounceMovies = StreamController.broadcast();
  StreamController<bool> isLoadingStrem = StreamController.broadcast();
  Timer? _debonceTimer;

  SearchMoviesDelegates({
    required this.initialMovies,
    required this.searchMovie,
  });

  void clearStream() {
    debounceMovies.close();
  }

  void _onQueryChanged(String query) {
    isLoadingStrem.add(true);
    if (_debonceTimer?.isActive ?? false) _debonceTimer!.cancel();

    _debonceTimer = Timer(const Duration(milliseconds: 500), () async {
      //if (query.isEmpty) {
      //  debounceMovies.add([]);
      //  return;
      //}
      final movies = await searchMovie(query);
      initialMovies = movies;
      debounceMovies.add(movies);
      isLoadingStrem.add(false);
    });
  }

  // Este paso no es obligatorio pero si queremos cambiar el texto que viene por defecto
  // para buscar en este caso es "Search" solo tenemos que implementar el override siguiente

  @override
  String get searchFieldLabel => 'Buscar películas';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      StreamBuilder(
        initialData: false,
        stream: isLoadingStrem.stream,
        builder: (context, snapshot) {
          if (snapshot.data ?? false) {
            return SpinPerfect(
              duration: const Duration(seconds: 20),
              spins: 10,
              infinite: true,
              child: IconButton(
                onPressed: () => query = '',
                icon: Icon(Icons.refresh_rounded),
              ),
            );
          }
          return FadeIn(
            animate: query.isNotEmpty,
            child: IconButton(
              onPressed: () => query = '',
              icon: Icon(Icons.clear_sharp),
            ),
          );
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        clearStream();
        close(context, null);
      },
      icon: Icon(Icons.arrow_back_ios),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return StreamBuilder(
      initialData: initialMovies,
      stream: debounceMovies.stream,
      builder: (context, snapshot) {
        final movies = snapshot.data ?? [];
        return ListView.builder(
          itemCount: movies.length,
          itemBuilder: (context, index) => _MovieItem(
            movies: movies[index],
            onMovieSelected: (context, movie) {
              clearStream();
              close(context, movie);
            },
          ),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    _onQueryChanged(query);

    return StreamBuilder(
      // future: searchMovie(query),
      initialData: initialMovies,
      stream: debounceMovies.stream,
      builder: (context, snapshot) {
        final movies = snapshot.data ?? [];

        return ListView.builder(
          itemCount: movies.length,
          itemBuilder: (context, index) => _MovieItem(
            movies: movies[index],
            onMovieSelected: (context, movie) {
              clearStream();
              close(context, movie);
            },
          ),
        );
      },
    );
  }
}

class _MovieItem extends StatelessWidget {
  final Movie movies;
  final Function onMovieSelected;

  const _MovieItem({required this.movies, required this.onMovieSelected});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        onMovieSelected(context, movies);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          children: [
            SizedBox(
              width: size.width * 0.2,
              child: ClipRRect(
                borderRadius: BorderRadiusGeometry.circular(24),
                child: Image.network(
                  movies.posterPath,
                  loadingBuilder: (context, child, loadingProgress) =>
                      FadeIn(child: child),
                ),
              ),
            ),
            SizedBox(width: 8),
            Column(
              children: [
                SizedBox(
                  width: size.width * 0.7,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(movies.title, style: textStyle.titleMedium),
                      Text(
                        movies.overview,
                        style: textStyle.labelMedium,
                        maxLines: 5,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Row(
                        children: [
                          const Spacer(),
                          Icon(Icons.star_half, color: Colors.amber.shade800),
                          const SizedBox(width: 6),
                          Text(
                            movies.voteAverage.toString(),
                            style: textStyle.bodyMedium!.copyWith(
                              color: Colors.yellow.shade800,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
