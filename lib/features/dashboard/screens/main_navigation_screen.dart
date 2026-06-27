import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/dashboard_provider.dart';
import '../../expense/screens/expense_screen.dart';
import '../../income/screens/income_screen.dart';
import '../../profile/screens/profile_screen.dart';
import '../../reports/screens/reports_screen.dart';
import 'home_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    HomeScreen(),
    IncomeScreen(),
    ExpenseScreen(),
    ReportsScreen(),
    ProfileScreen(),
  ];

  final List<NavigationDestination> _destinations = const [
    NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Home'),
    NavigationDestination(icon: Icon(Icons.attach_money_outlined), selectedIcon: Icon(Icons.attach_money), label: 'Income'),
    NavigationDestination(icon: Icon(Icons.money_off_outlined), selectedIcon: Icon(Icons.money_off), label: 'Expense'),
    NavigationDestination(icon: Icon(Icons.bar_chart_outlined), selectedIcon: Icon(Icons.bar_chart), label: 'Reports'),
    NavigationDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person), label: 'Profile'),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ChangeNotifierProvider(
      create: (_) => DashboardProvider(),
      child: Scaffold(
        body: _screens[_currentIndex],
        bottomNavigationBar: NavigationBar(
          height: 72,
          backgroundColor: theme.colorScheme.surface,
          indicatorColor: theme.colorScheme.primaryContainer,
          selectedIndex: _currentIndex,
          onDestinationSelected: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          destinations: _destinations,
        ),
      ),
    );
  }
}
