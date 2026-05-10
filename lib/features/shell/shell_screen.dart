import 'package:flutter/material.dart';
import 'package:go_router/src/route.dart';
import 'package:optom/features/home/home_screen.dart';
import 'package:optom/features/products/product_screen.dart';

class ShellScreen extends StatefulWidget {
  const ShellScreen({super.key, required StatefulNavigationShell navShell, required List<Widget> children});

  @override
  State<ShellScreen> createState() => _ShellScreenState();
}

class _ShellScreenState extends State<ShellScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [const HomeScreen(), const ProductsScreen()];

  final List<String> _titles = ['Home', 'Products'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
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
