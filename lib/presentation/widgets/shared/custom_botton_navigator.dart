import 'package:flutter/material.dart';

class CustomBottonNavigator extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const CustomBottonNavigator({super.key, required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      elevation: 12,
      currentIndex: currentIndex,
      onTap: onTap,
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
