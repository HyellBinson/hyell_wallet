import 'package:flutter/material.dart';
import 'package:hyell_wallet/core/constants/app_colors.dart';
import 'package:hyell_wallet/screens/auto_notifications/notifications_setting_screen.dart';
import 'package:hyell_wallet/screens/auth/change_pin_screen.dart';
import 'package:hyell_wallet/screens/auth/biometric_screen.dart';
import 'package:hyell_wallet/screens/auth/change_login_pin_screen.dart';
import 'package:hyell_wallet/screens/settings/appearance_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,

      appBar: AppBar(
        title: Text(
          'Settings',
          style: TextStyle(
            color: theme.colorScheme.onSurface,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        iconTheme: IconThemeData(color: theme.colorScheme.onSurface),
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
                    'Security',
                    style: TextStyle(
                      color: theme.brightness == Brightness.dark
                          ? AppColors.textSecondaryDark
                          : AppColors.textSecondary,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              _settingsItem(
                context: context,
                icon: Icons.password_outlined,
                title: 'Change Login PIN',
                subtitle: 'Change your 6-digit login PIN',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ChangeLoginPinScreen(),
                    ),
                  );
                },
              ),

              _settingsItem(
                context: context,
                icon: Icons.lock_outline,
                title: 'Change PIN',
                subtitle: 'Change your HYELL transaction PIN',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ChangePinScreen(),
                    ),
                  );
                },
              ),

              _settingsItem(
                context: context,
                icon: Icons.fingerprint,
                title: 'Biometric Authentication',
                subtitle: 'Use your fingerprint to secure HYELL',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const BiometricScreen(),
                    ),
                  );
                },
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 28, 20, 10),
                  child: Text(
                    'Notifications',
                    style: TextStyle(
                      color: theme.brightness == Brightness.dark
                          ? AppColors.textSecondaryDark
                          : AppColors.textSecondary,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              _settingsItem(
                context: context,
                icon: Icons.notifications_outlined,
                title: 'Notifications',
                subtitle: 'Manage your HYELL notifications',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const NotificationsSettingScreen(),
                    ),
                  );
                },
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20, 28, 20, 10),
                  child: Text(
                    'Preferences',
                    style: TextStyle(
                      color: theme.brightness == Brightness.dark
                          ? AppColors.textSecondaryDark
                          : AppColors.textSecondary,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              _settingsItem(
                context: context,
                icon: Icons.language_outlined,
                title: 'Language',
                subtitle: 'Choose your preferred language',
                onTap: () {},
              ),

              _settingsItem(
                context: context,
                icon: Icons.palette_outlined,
                title: 'Appearance',
                subtitle: 'Customize how HYELL looks',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AppearanceScreen(),
                    ),
                  );
                },
              ),

              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20, 28, 20, 10),
                  child: Text(
                    'About',
                    style: TextStyle(
                      color: theme.brightness == Brightness.dark
                          ? AppColors.textSecondaryDark
                          : AppColors.textSecondary,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              _settingsItem(
                context: context,
                icon: Icons.info_outline,
                title: 'About HYELL',
                subtitle: 'Learn more about HYELL',
                onTap: () {},
              ),

              _settingsItem(
                context: context,
                icon: Icons.description_outlined,
                title: 'Terms & Privacy',
                subtitle: 'Read HYELL terms and privacy policy',
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _settingsItem({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: theme.colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: theme.colorScheme.primary),
              ),

              const SizedBox(width: 14),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: theme.colorScheme.onSurface,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      subtitle,
                      style: TextStyle(
                        color: theme.brightness == Brightness.dark
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
                color: theme.brightness == Brightness.dark
                    ? AppColors.textSecondaryDark
                    : AppColors.textSecondary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
