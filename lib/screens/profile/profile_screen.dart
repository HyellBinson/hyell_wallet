import 'package:flutter/material.dart';
import 'package:hyell_wallet/core/constants/app_colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.background,

      appBar: AppBar(
        backgroundColor: isDark
            ? AppColors.backgroundDark
            : AppColors.background,
        elevation: 0,
        centerTitle: true,

        iconTheme: IconThemeData(
          color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
        ),

        title: Text(
          'Profile',
          style: TextStyle(
            color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
            fontSize: 19,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 10),

              // Profile picture
              CircleAvatar(
                radius: 50,
                backgroundColor: AppColors.primary,
                child: Icon(
                  Icons.person,
                  size: 55,
                  color: isDark ? Colors.black : Colors.white,
                ),
              ),

              const SizedBox(height: 16),

              // Name
              Text(
                'Hyell',
                style: TextStyle(
                  color: isDark
                      ? AppColors.textPrimaryDark
                      : AppColors.textPrimary,
                  fontSize: 23,
                  fontWeight: FontWeight.w700,
                ),
              ),

              const SizedBox(height: 5),

              // Wallet name
              Text(
                'HYELL Wallet',
                style: TextStyle(
                  color: isDark
                      ? AppColors.textSecondaryDark
                      : AppColors.textSecondary,
                  fontSize: 14,
                ),
              ),

              const SizedBox(height: 30),

              // Profile information
              _ProfileTile(
                icon: Icons.person_outline_rounded,
                title: 'Full Name',
                value: 'Hyell',
                isDark: isDark,
              ),

              _ProfileTile(
                icon: Icons.phone_outlined,
                title: 'Phone Number',
                value: 'Not added',
                isDark: isDark,
              ),

              _ProfileTile(
                icon: Icons.email_outlined,
                title: 'Email Address',
                value: 'Not added',
                isDark: isDark,
              ),

              _ProfileTile(
                icon: Icons.calendar_today_outlined,
                title: 'Member Since',
                value: '2026',
                isDark: isDark,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProfileTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final bool isDark;

  const _ProfileTile({
    required this.icon,
    required this.title,
    required this.value,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? AppColors.dividerDark : AppColors.divider,
        ),
      ),

      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,

            decoration: BoxDecoration(
              color: isDark
                  ? AppColors.primary.withOpacity(0.15)
                  : AppColors.primarySoft,
              borderRadius: BorderRadius.circular(12),
            ),

            child: Icon(icon, color: AppColors.primary, size: 22),
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
                        ? AppColors.textSecondaryDark
                        : AppColors.textSecondary,
                    fontSize: 12,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  value,
                  style: TextStyle(
                    color: isDark
                        ? AppColors.textPrimaryDark
                        : AppColors.textPrimary,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
