import 'package:flutter/material.dart';
import 'package:hyell_wallet/core/constants/app_colors.dart';

class NotificationsSettingScreen extends StatefulWidget {
  const NotificationsSettingScreen({super.key});

  @override
  State<NotificationsSettingScreen> createState() =>
      _NotificationsSettingScreenState();
}

class _NotificationsSettingScreenState
    extends State<NotificationsSettingScreen> {
  bool transactionUpdates = true;
  bool promotions = true;
  bool securityAlerts = true;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.background,

      appBar: AppBar(
        title: Text(
          'Notifications',
          style: TextStyle(
            color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: isDark
            ? AppColors.backgroundDark
            : AppColors.background,
        elevation: 0,
        iconTheme: IconThemeData(
          color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                  child: Text(
                    'Notifications',
                    style: TextStyle(
                      color: isDark
                          ? AppColors.textSecondaryDark
                          : AppColors.textSecondary,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              _notificationItem(
                title: 'Transaction Updates',
                subtitle: 'Get notified when your purchases are completed.',
                value: transactionUpdates,
                isDark: isDark,
                onChanged: (value) {
                  setState(() {
                    transactionUpdates = value;
                  });
                },
              ),

              _notificationItem(
                title: 'Promotions & Rewards',
                subtitle: 'Receive HYELL bonuses, cashback and special offers.',
                value: promotions,
                isDark: isDark,
                onChanged: (value) {
                  setState(() {
                    promotions = value;
                  });
                },
              ),

              _notificationItem(
                title: 'Security Alerts',
                subtitle: 'Receive important security notifications.',
                value: securityAlerts,
                isDark: isDark,
                onChanged: (value) {
                  setState(() {
                    securityAlerts = value;
                  });
                },
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _notificationItem({
    required String title,
    required String subtitle,
    required bool value,
    required bool isDark,
    required ValueChanged<bool> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDark ? AppColors.surfaceDark : AppColors.surface,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
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

            const SizedBox(width: 12),

            Switch(
              value: value,
              onChanged: onChanged,
              activeThumbColor: AppColors.primary,
            ),
          ],
        ),
      ),
    );
  }
}
