import 'package:flutter/material.dart';
import 'package:hyell_wallet/screens/main_shell.dart';
import '../../core/constants/app_colors.dart';
import '../home/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _textAnimation;
  late AnimationController _loaderController;

  late Animation<double> _dotOneAnimation;
  late Animation<double> _dotTwoAnimation;
  late Animation<double> _dotThreeAnimation;

  @override
  void initState() {
    super.initState();

    // Main splash animation controller
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    // Logo fade animation
    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    );

    // Logo scale animation
    _scaleAnimation = Tween<double>(
      begin: 0.7,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    // Text animation
    _textAnimation = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.35, 1.0, curve: Curves.easeOutCubic),
    );

    // Loader controller
    _loaderController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    // Loader animations
    _dotOneAnimation = Tween<double>(begin: 0.7, end: 1.3).animate(
      CurvedAnimation(
        parent: _loaderController,
        curve: const Interval(0.0, 0.35, curve: Curves.easeInOut),
      ),
    );

    _dotTwoAnimation = Tween<double>(begin: 0.7, end: 1.3).animate(
      CurvedAnimation(
        parent: _loaderController,
        curve: const Interval(0.2, 0.55, curve: Curves.easeInOut),
      ),
    );

    _dotThreeAnimation = Tween<double>(begin: 0.7, end: 1.3).animate(
      CurvedAnimation(
        parent: _loaderController,
        curve: const Interval(0.4, 0.75, curve: Curves.easeInOut),
      ),
    );

    // Start animations AFTER all animations have been created.

    _controller.forward();

    _loaderController.repeat();

    Future.delayed(const Duration(seconds: 3), () {
      if (!mounted) return;

      Navigator.of(
        context,
      ).pushReplacement(MaterialPageRoute(builder: (_) => const MainShell()));
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _loaderController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final logoSize = (constraints.maxWidth * 0.50).clamp(
                120.0,
                170.0,
              );
              final titleSize = (constraints.maxWidth * 0.085).clamp(
                28.0,
                38.0,
              );

              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      return Opacity(
                        opacity: _fadeAnimation.value,
                        child: Transform.scale(
                          scale: _scaleAnimation.value,
                          child: child,
                        ),
                      );
                    },

                    child: Image.asset(
                      'assets/images/logo_icon.png',
                      width: logoSize,
                    ),
                  ),
                  const SizedBox(height: 32),
                  AnimatedBuilder(
                    animation: _loaderController,
                    builder: (context, child) {
                      return Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Transform.scale(
                            scale: _dotOneAnimation.value,
                            child: child,
                          ),
                          const SizedBox(width: 8),
                          Transform.scale(
                            scale: _dotTwoAnimation.value,
                            child: child,
                          ),
                          const SizedBox(width: 8),
                          Transform.scale(
                            scale: _dotThreeAnimation.value,
                            child: child,
                          ),
                        ],
                      );
                    },
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                  // text
                  /* AnimatedBuilder(
                    animation: _textAnimation,
                    builder: (context, child) {
                      return Opacity(
                        opacity: _textAnimation.value,
                        child: child,
                      );
                    },
                    child: Text(
                      'Hyell',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        letterSpacing: 4,
                        fontSize: titleSize,
                        color: AppColors.primary,
                      ),
                    ),
                  ),*/
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
