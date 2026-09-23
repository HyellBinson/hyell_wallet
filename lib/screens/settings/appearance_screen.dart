import 'package:flutter/material.dart';

import 'package:hyell_wallet/app.dart';
import 'package:hyell_wallet/core/constants/app_colors.dart';
import 'package:hyell_wallet/core/theme/theme_controller.dart';

class AppearanceScreen extends StatelessWidget {
  const AppearanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = ThemeControllerProvider.of(context);
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,

      appBar: AppBar(
        title: Text(
          'Appearance',
          style: TextStyle(
            color: theme.colorScheme.onSurface,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: theme.appBarTheme.backgroundColor,
        elevation: 0,
        iconTheme: IconThemeData(color: theme.colorScheme.onSurface),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Choose how HYELL looks',
                style: TextStyle(
                  color: theme.colorScheme.onSurface,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                'Select your preferred appearance.',
                style: TextStyle(
                  color: theme.colorScheme.onSurface,
                  fontSize: 13,
                ),
              ),

              const SizedBox(height: 24),

              _appearanceOption(
                context: context,
                themeController: themeController,
                icon: Icons.light_mode_outlined,
                title: 'Light',
                subtitle: 'Always use light mode',
                mode: ThemeMode.light,
              ),

              _appearanceOption(
                context: context,
                themeController: themeController,
                icon: Icons.dark_mode_outlined,
                title: 'Dark',
                subtitle: 'Always use dark mode',
                mode: ThemeMode.dark,
              ),

              _appearanceOption(
                context: context,
                themeController: themeController,
                icon: Icons.settings_suggest_outlined,
                title: 'System default',
                subtitle: 'Follow your device settings',
                mode: ThemeMode.system,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _appearanceOption({
    required BuildContext context,
    required ThemeController themeController,
    required IconData icon,
    required String title,
    required String subtitle,
    required ThemeMode mode,
  }) {
    final theme = Theme.of(context);
    final bool isSelected = themeController.themeMode == mode;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () {
          themeController.setThemeMode(mode);
        },
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: theme.colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(14),
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
                        color: Theme.of(context).brightness == Brightness.dark
                            ? AppColors.textSecondaryDark
                            : AppColors.textSecondary,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),

              Icon(
                isSelected
                    ? Icons.radio_button_checked
                    : Icons.radio_button_unchecked,
                color: Theme.of(context).brightness == Brightness.dark
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
