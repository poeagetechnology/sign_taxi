import 'package:flutter/material.dart';

/// Modern bottom navigation bar using Flutter's native BottomNavigationBar.
class CustomBottomNavBar extends StatelessWidget {
  final List<BottomNavItem> items;
  final Function(int) onItemTapped;
  final int currentIndex;

  const CustomBottomNavBar({
    super.key,
    required this.items,
    required this.onItemTapped,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onItemTapped,
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      selectedItemColor: theme.primaryColor,
      unselectedItemColor: const Color(0xFF94A3B8),
      selectedFontSize: 11,
      unselectedFontSize: 11,
      selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w700),
      unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500),
      iconSize: 24,
      elevation: 12,
      items: items
          .map(
            (item) => BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(bottom: 3),
                child: Icon(item.icon),
              ),
              activeIcon: Padding(
                padding: const EdgeInsets.only(bottom: 3),
                child: Icon(item.activeIcon ?? item.icon),
              ),
              label: item.label,
            ),
          )
          .toList(),
    );
  }
}

class BottomNavItem {
  final IconData icon;
  final IconData? activeIcon;
  final String label;

  BottomNavItem({required this.icon, this.activeIcon, required this.label});
}
