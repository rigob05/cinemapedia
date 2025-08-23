import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/widgets/movies/movie_poster_link.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class MoviesMansonry extends StatefulWidget {
  final List<Movie> movies;
  final VoidCallback? loadNextPage;
  

  MoviesMansonry({
    required this.movies, 
    this.loadNextPage, 
     
  });


  @override
  State<MoviesMansonry> createState() => _MoviesMansonryState();
}

class _MoviesMansonryState extends State<MoviesMansonry> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController;
    scrollController.addListener((){
      // Aqui optenemos la posicion actual 
      final position = scrollController.position.pixels;
      // Aqui optenemos el limite maximo del scroll
      final max = scrollController.position.maxScrollExtent;

      // umbral de 300px antes del final para lanzar la peticiond de cargar la siguiente pagina
      if (position + 300 >= max){
        widget.loadNextPage?.call();
      }
    });
    
  }

  @override
  void dispose() {
    scrollController.dispose();
    
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MasonryGridView.count(
      controller: scrollController,
      crossAxisCount: 3, 
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      itemCount: widget.movies.length,
      itemBuilder: (context, index) {
        if (index == 1){
          return Column(
            children: [
              SizedBox(height: 40),
              MoviePosterLink (movie: widget.movies[index]),
            ],
          );
        }
        return MoviePosterLink (movie: widget.movies[index]);
      },
    );
  }
}

