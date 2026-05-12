import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ShellScreen extends StatelessWidget {
  final StatefulNavigationShell navShell;
  final List<Widget> children;

  const ShellScreen({
    super.key,
    required this.children,
    required this.navShell,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: navShell.currentIndex,
        children: children,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: navShell.currentIndex,
        onDestinationSelected: (index) => navShell.goBranch(
          index,
          initialLocation: index == navShell.currentIndex,
        ),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.sell_outlined),
            selectedIcon: Icon(Icons.sell_rounded),
            label: 'Selling',
          ),
          NavigationDestination(
            icon: Icon(Icons.inventory_2_outlined),
            selectedIcon: Icon(Icons.inventory_2),
            label: 'Products',
          ),
        ],
        elevation: 2,
        animationDuration: const Duration(milliseconds: 300),
      ),
    );
  }
}