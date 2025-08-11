import 'package:flutter/material.dart';

class CustomBottonNavigator extends StatelessWidget {
  const CustomBottonNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      elevation: 12,
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home_max), label: 'Hogar'),
        BottomNavigationBarItem(
          icon: Icon(Icons.label_important_outline),
          label: 'Categorias',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite, color: Colors.red),
          label: 'Favoritos',
        ),
      ],
    );
  }
}
