import 'package:flutter/material.dart';
import 'package:hyell_wallet/screens/more/more_screen.dart';
import '../screens/home/home_screen.dart';
import '../screens/rewards/rewards_screen.dart';
import '../screens/data/data_screen.dart';
import '../screens/activity/activity_screen.dart';
import '../screens/me profile/me_screen.dart';

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    const HomeScreen(),
    const RewardsScreen(),
    const DataScreen(),
    const ActivityScreen(),
    const MeScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _pages),

      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },

        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_rounded), label: 'Home'),
        ],
      ),
    );
  }
}
