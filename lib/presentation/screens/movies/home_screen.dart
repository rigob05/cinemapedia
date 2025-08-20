import 'package:cinemapedia/presentation/providers/movies/frist_loader.dart';
import 'package:cinemapedia/presentation/providers/movies/movies_providers.dart';
import 'package:cinemapedia/presentation/providers/movies/movies_slideshow_provider.dart';
import 'package:cinemapedia/presentation/widgets/movies/movies_horizontal_listview.dart';
import 'package:cinemapedia/presentation/widgets/shared/full_screen_loader.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends StatelessWidget {
  static final name = 'home-screen';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _HomeView(),
    );
  }
}

class _HomeView extends ConsumerStatefulWidget {
  const _HomeView();

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<_HomeView> {
  @override
  void initState() {
    super.initState();

    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
    ref.read(popularMoviesProvider.notifier).loadNextPage();
    ref.read(topRatedMoviesProvider.notifier).loadNextPage();
    ref.read(upComingMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    final initialLoading = ref.watch(initialLoadingProvider);
    if (initialLoading) return FullScreenLoader();

    final nowPLayingMoviesSlide = ref.watch(moviesSlideShowPRovider);
    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final popularMovies = ref.watch(popularMoviesProvider);
    final topRatedMovies = ref.watch(topRatedMoviesProvider);
    final upComingMovies = ref.watch(upComingMoviesProvider);

    return CustomScrollView(
      slivers: [
        const SliverAppBar(
          floating: true,
          flexibleSpace: FlexibleSpaceBar(title: CustomAppbar()),
        ),

        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            return Column(
              children: [
                // CustomAppbar(),
                MoviesSlideshow(movies: nowPLayingMoviesSlide),
                MoviesHorizontalListview(
                  movies: nowPlayingMovies,
                  title: 'Solo en cines BB',
                  subTitle: 'Lunes 11',
                  loadNextPage: () {
                    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
                  },
                ),
                MoviesHorizontalListview(
                  movies: popularMovies,
                  title: 'Most Popular',
                  subTitle: 'Pa todo el tiempo',
                  loadNextPage: () {
                    ref.read(popularMoviesProvider.notifier).loadNextPage();
                  },
                ),
                MoviesHorizontalListview(
                  movies: topRatedMovies,
                  title: 'Top Rated',
                  subTitle: 'CHTM por todo',
                  loadNextPage: () {
                    ref.read(topRatedMoviesProvider.notifier).loadNextPage();
                  },
                ),
                MoviesHorizontalListview(
                  movies: upComingMovies,
                  title: 'Las que vienen',
                  subTitle: 'Ahi viene lo chido',
                  loadNextPage: () {
                    ref.read(upComingMoviesProvider.notifier).loadNextPage();
                  },
                ),
                const SizedBox(height: 20),
              ],
            );
          }),
        ),
      ],
    );
  }
}
