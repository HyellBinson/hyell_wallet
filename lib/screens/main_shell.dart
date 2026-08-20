import 'package:flutter/material.dart';
import 'package:hyell_wallet/screens/more/more_screen.dart';
import '../screens/home/home_screen.dart';
import '../screens/rewards/rewards_screen.dart';
import '../screens/data/data_screen.dart';
import '../screens/activity/activity_screen.dart';
import '../screens/me profile/me_screen.dart';
import '../core/constants/app_colors.dart';

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

      bottomNavigationBar: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
          child: Container(
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(22),
                border: Border.all(
                  color: Theme.of(context).colorScheme.outlineVariant,
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _NavItem(
                    icon: Image.asset(
                      'assets/images/nav_icon.png',
                      width: 30,
                      height: 30,
                    ),
                    label: 'Home',
                    isSelected: _currentIndex == 0,
                    onTap: () {
                      setState(() {
                        _currentIndex = 0;
                      });
                    },
                  ),

                  _NavItem(
                    icon: const Icon(Icons.diamond_rounded),
                    label: 'Rewards',
                    isSelected: _currentIndex == 1,
                    onTap: () {
                      setState(() {
                        _currentIndex = 1;
                      });
                    },
                  ),

                  _NavItem(
                    icon: const Icon(Icons.wifi),
                    label: 'Data',
                    isSelected: _currentIndex == 2,
                    onTap: () {
                      setState(() {
                        _currentIndex = 2;
                      });
                    },
                  ),

                  _NavItem(
                    icon: const Icon(Icons.receipt_long),
                    label: 'Activity',
                    isSelected: _currentIndex == 3,
                    onTap: () {
                      setState(() {
                        _currentIndex = 3;
                      });
                    },
                  ),

                  _NavItem(
                    icon: const Icon(Icons.person_2_rounded),
                    label: 'Me',
                    isSelected: _currentIndex == 4,
                    onTap: () {
                      setState(() {
                        _currentIndex = 4;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final Widget icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  Widget _buildIcon(BuildContext context) {
    final iconColor = isSelected ? AppColors.primary : AppColors.textSecondary;

    if (icon is Icon) {
      final originalIcon = icon as Icon;

      return Icon(originalIcon.icon, size: 23, color: iconColor);
    }

    return ColorFiltered(
      colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
      child: icon,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedSlide(
            offset: isSelected ? const Offset(0, -0.30) : Offset.zero,
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeOutCubic,
            child: _buildIcon(context),
          ),
          const SizedBox(height: 4),
          AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 200),
            style: TextStyle(
              color: isSelected ? AppColors.primary : AppColors.textSecondary,
              fontSize: 11,
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
            ),
            child: Text(label),
          ),
        ],
      ),
    );
  }
}
