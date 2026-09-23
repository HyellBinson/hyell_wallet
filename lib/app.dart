import 'package:flutter/material.dart';

import 'core/constants/app_colors.dart';
import 'core/theme/theme_controller.dart';
import 'screens/splash/splash_screen.dart';

class HyellWalletApp extends StatefulWidget {
  const HyellWalletApp({super.key});

  @override
  State<HyellWalletApp> createState() => _HyellWalletAppState();
}

class _HyellWalletAppState extends State<HyellWalletApp> {
  final ThemeController _themeController = ThemeController();

  @override
  void initState() {
    super.initState();

    _themeController.loadTheme();
  }

  @override
  void dispose() {
    _themeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ThemeControllerProvider(
      controller: _themeController,
      child: AnimatedBuilder(
        animation: _themeController,
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,

            themeMode: _themeController.themeMode,

            theme: ThemeData(
              brightness: Brightness.light,
              scaffoldBackgroundColor: AppColors.background,
              colorScheme: const ColorScheme.light(
                primary: AppColors.primary,
                surface: AppColors.surface,
                onSurface: AppColors.textPrimary,
              ),
              appBarTheme: const AppBarTheme(
                backgroundColor: AppColors.background,
                foregroundColor: AppColors.textPrimary,
                elevation: 0,
              ),
            ),

            darkTheme: ThemeData(
              brightness: Brightness.dark,
              scaffoldBackgroundColor: AppColors.backgroundDark,
              colorScheme: const ColorScheme.dark(
                primary: AppColors.primary,
                surface: AppColors.surfaceDark,
                onSurface: AppColors.textPrimaryDark,
              ),
              appBarTheme: const AppBarTheme(
                backgroundColor: AppColors.backgroundDark,
                foregroundColor: AppColors.textPrimaryDark,
                elevation: 0,
              ),
            ),

            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}

class ThemeControllerProvider extends InheritedNotifier<ThemeController> {
  const ThemeControllerProvider({
    super.key,
    required ThemeController controller,
    required super.child,
  }) : super(notifier: controller);

  static ThemeController of(BuildContext context) {
    final provider = context
        .dependOnInheritedWidgetOfExactType<ThemeControllerProvider>();

    return provider!.notifier!;
  }
}
