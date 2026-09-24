import 'package:flutter/material.dart';
import 'package:hyell_wallet/core/constants/app_colors.dart';
import '../settings/settings_screen.dart';
import '../transaction/transactions_screen.dart';
import '../rewards/rewards_screen.dart';
import '../activity/activity_screen.dart';
import '../profile/profile_screen.dart';

class MeScreen extends StatelessWidget {
  const MeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: const Color(0xFF0F1916),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const ProfileScreen(),
                          ),
                        );
                      },
                      borderRadius: BorderRadius.circular(50),

                      child: CircleAvatar(
                        radius: 30,
                        backgroundColor: AppColors.primary,
                        child: Icon(
                          Icons.person,
                          size: 32,
                          color: isDark ? Colors.black : Colors.white,
                        ),
                      ),
                    ),

                    const SizedBox(width: 14),

                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hi, Hyell',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 21,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          SizedBox(height: 5),

                          Text(
                            'HYELL Wallet',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),

                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SettingsScreen(),
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.settings_outlined,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                  ],
                ),
              ),
              // safety card
              const SizedBox(height: 12),

              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColors.primarySoft, AppColors.primary],
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    const Text('🛡️', style: TextStyle(fontSize: 25)),

                    const SizedBox(width: 12),

                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Keep your account secure',
                            style: TextStyle(
                              color: AppColors.textPrimary,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          SizedBox(height: 4),

                          Text(
                            'Protect your HYELL account and funds.',
                            style: TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),

                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 9,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.textPrimary,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        'View',
                        style: TextStyle(
                          color: AppColors.primary,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: isDark ? AppColors.surfaceDark : AppColors.surface,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    _menuItem(
                      icon: Icons.receipt_long_outlined,
                      title: 'Transaction History',
                      subtitle: 'View your data and airtime transactions',
                      isDark: isDark,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const TransactionsScreen(),
                          ),
                        );
                      },
                    ),

                    _menuItem(
                      icon: Icons.card_giftcard_outlined,
                      title: 'My Rewards',
                      subtitle: 'View your bonuses and cashback',
                      isDark: isDark,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const RewardsScreen(),
                          ),
                        );
                      },
                    ),

                    _menuItem(
                      icon: Icons.bar_chart_outlined,
                      title: 'My Activity',
                      subtitle: 'See your recent account activity',
                      isDark: isDark,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const ActivityScreen(),
                          ),
                        );
                      },
                    ),

                    _menuItem(
                      icon: Icons.people_outline,
                      title: 'Invite Friends',
                      subtitle: 'Invite friends and earn rewards',
                      isDark: isDark,
                      onTap: () {},
                    ),
                  ],
                ),
              ),

              // another container
              const SizedBox(height: 20),

              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: isDark ? AppColors.surfaceDark : AppColors.surface,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    _menuItem(
                      icon: Icons.security_outlined,
                      title: 'Security Center',
                      subtitle: 'Protect your HYELL account',
                      isDark: isDark,
                      onTap: () {},
                    ),

                    _menuItem(
                      icon: Icons.support_agent_outlined,
                      title: 'Customer Support',
                      subtitle: 'Get help with HYELL',
                      isDark: isDark,
                      onTap: () {},
                    ),

                    _menuItem(
                      icon: Icons.star_outline,
                      title: 'Rate HYELL',
                      subtitle: 'Tell us what you think',
                      isDark: isDark,
                      onTap: () {},
                    ),

                    _menuItem(
                      icon: Icons.info_outline,
                      title: 'About HYELL',
                      subtitle: 'Learn more about HYELL',
                      isDark: isDark,
                      onTap: () {},
                    ),

                    _menuItem(
                      icon: Icons.person_outline,
                      title: 'Log out',
                      subtitle: 'Sign out of your HYELL account',
                      isDark: isDark,
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _menuItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool isDark,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: isDark
                    ? AppColors.primary.withOpacity(0.15)
                    : AppColors.primarySoft,
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Icon(
                Icons.circle,
                color: AppColors.primary,
                size: 23,
              ),
            ),

            const SizedBox(width: 14),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: isDark
                          ? AppColors.textPrimaryDark
                          : AppColors.textPrimary,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    subtitle,
                    style: TextStyle(
                      color: isDark
                          ? AppColors.textSecondaryDark
                          : AppColors.textSecondary,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),

            Icon(
              Icons.chevron_right,
              color: isDark
                  ? AppColors.textSecondaryDark
                  : AppColors.textSecondary,
              size: 22,
            ),
          ],
        ),
      ),
    );
  }
}
