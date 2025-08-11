import 'package:cinemapedia/presentation/providers/movies_providers.dart';
import 'package:cinemapedia/presentation/providers/movies_slideshow_provider.dart';
import 'package:cinemapedia/presentation/widgets/movies/movies_horizontal_listview.dart';
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
      bottomNavigationBar: CustomBottonNavigator(),
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
  }

  @override
  Widget build(BuildContext context) {
    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final nowPLayingMoviesSlide = ref.watch(moviesSlideShowPRovider);

    return Column(
      children: [
        CustomAppbar(),
        MoviesSlideshow(movies: nowPLayingMoviesSlide),
        MoviesHorizontalListview(
          movies: nowPlayingMovies,
          title: 'Solo en cines BB',
          subTitle: 'Lunes 11',
        ),
      ],
    );
  }
}
