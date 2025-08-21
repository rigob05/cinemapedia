import 'package:flutter/material.dart';
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
      body: const _EmptyFavorites(),
    );
  }
}

class _EmptyFavorites extends StatelessWidget {
  const _EmptyFavorites();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.favorite_border, size: 64),
            const SizedBox(height: 12),
            Text('Aún no tienes favoritos', style: theme.titleMedium),
            const SizedBox(height: 6),
            Text(
              'Marca películas con el corazón para verlas aquí.',
              style: theme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
