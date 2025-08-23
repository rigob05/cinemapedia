import 'package:cinemapedia/presentation/providers/storage/local_favorite_movies_provider.dart';
import 'package:cinemapedia/presentation/widgets/movies/movies_mansonry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class FavoritesView extends StatelessWidget {
  static const name = '/favorites';
  const FavoritesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favoritos'),
        actions: [
          IconButton(
            tooltip: 'Ir a Home',
            onPressed: () => context.go('/'),
            icon: const Icon(Icons.home_outlined),
          ),
        ],
      ),
      body: _LoadFavorite(),
    );
  }
}

class _LoadFavorite extends ConsumerStatefulWidget {
  const _LoadFavorite();

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoadFavoriteState();
}

class _LoadFavoriteState extends ConsumerState<_LoadFavorite> {
  bool isLastPage = false;
  bool isLoading = false;
  

  @override
  void initState() {
    super.initState();
    loadNextPage();
  }

  void loadNextPage() async {
    if (isLastPage || isLoading) return;
    isLoading = true;
    final movies = await ref
        .read(favoriteMovieProvider.notifier)
        .loadNextPage();
    isLoading = false;

    if (movies.isEmpty) {
      isLastPage = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final movies = ref.watch(favoriteMovieProvider).values.toList();

    if (movies.isEmpty){
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.favorite, size: 60,),
            Text('Ohhh No!!!!'),
            Text('No tienes peliculas favoritas')
          ],
        ),
      );
    }




    return Scaffold(
      body: MoviesMansonry(
        movies: movies, 
        loadNextPage: loadNextPage
      ),
    );
  }
}

