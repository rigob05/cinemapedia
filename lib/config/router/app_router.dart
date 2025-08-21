import 'package:cinemapedia/presentation/screens/screens.dart';
import 'package:cinemapedia/presentation/views/categorias_views.dart';
import 'package:cinemapedia/presentation/views/favorite_views.dart';
import 'package:cinemapedia/presentation/widgets/shared/custom_botton_navigator.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  initialLocation: "/",
  routes: [
    StatefulShellRoute.indexedStack(

      builder: (context,state, navigationShell) {
        return Scaffold(
          body: navigationShell, // muestra la rama activa
          bottomNavigationBar: CustomBottonNavigator(
            currentIndex: navigationShell.currentIndex,
            onTap: (i) => navigationShell.goBranch(
              i,
              // si tocas la misma pestaña, opcionalmente vuelve a su raíz:
              initialLocation: i == navigationShell.currentIndex,
            ),
          ),
        );
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/',
              name: HomeScreen.name,
              builder: (context, state) => HomeScreen(),
              routes: [
                GoRoute(
                  path: '/movie/:id',
                  name: MovieScreen.name,
                  builder: (context, state) {
                    final movieId = state.pathParameters['id'] ?? 'no-id';
                    return MovieScreen(movieId: movieId);
                  },
                ),
              ],
            ),
          ],
        ),
        // segunda rama
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/categories',
              name: CategoriasViews.name,
              builder: (context, state) => CategoriasViews(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/favorites',
              name: FavoritesView.name,
              builder: (context, state) => FavoritesView(),
            ),
          ],
        ),
      ],
    ),
  ],
);
